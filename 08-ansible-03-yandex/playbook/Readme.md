# Описание site.yml playbook

Плейбук описывает развертывание `clickhouse` и `vector` на хосты, указанные в `inventory`

- [group_vars clickhouse](#group_vars_clickhouse)
- [group_vars vector](#group_vars_vector)
- [Inventory](#inventory)
- [Playbook](#playbook)
  - [Play "Install Clickhouse"](#play_install_clickhouse)
  - [Tasks Play "Install Clickhouse"](#tasks_play_install_clickhouse)
  - [Play "Install Vector"](#play_install_vector)
  - [Tasks Play "Install Vector"](#tasks_play_install_vector)
- [Template](#template)

## group_vars_clickhouse

| Переменная  | Назначение  |
|:---|:---|
| `clickhouse_version` | версия `clickhouse` |
| `clickhouse_packages` | имена пакетов для скачивания и установки |

## group_vars_vector

| Переменная  | Назначение  |
|:---|:---|
| `vector_version` | версия `vector` |
| `vector_url` | URL-адрес пакета `vector` |
| `vector_config_dir` | каталог для конфига `vector` |
| `vector_config` | конфиг файл `vector` |

## group_vars_lighthouse

| Переменная  | Назначение  |
|:---|:---|
| `lighthouse_vcs` | URL-адрес дистрибутива `lighthouse` |
| `lighthouse_location_dir` | каталог для `lighthouse` |
| `lighthouse_access_log_name` | имя файло логов |
| `nginx_user_name` | имя пользователя nginx |

## Inventory

Формируется при каждом запуске `terraform`, имеет вид
```
clickhouse:
  hosts:
    clickhouse-01: 
      ansible_host: 62.84.117.148
      ansible_user: eurus_cloud
  
lighthouse:
  hosts:
    lighthouse-01: 
      ansible_host: 89.169.144.132
      ansible_user: eurus_cloud
  
vector:
  hosts:
    vector-01: 
      ansible_host: 89.169.131.242
      ansible_user: eurus_cloud
```

## Playbook

Playbook состоит из 3 `play`

### play_install_clickhouse

Применяется на группу хостов "clickhouse", предназначен для установки и запуска `clickhouse`

Обработчик (handler) для запуска `clickhouse-server`, таски обращаются к нему через ключ **notify: Start clickhouse service**
```yaml
  handlers:
    - name: Start clickhouse service
      become: true
      ansible.builtin.service:
        name: clickhouse-server
        state: restarted
```

### tasks_play_install_clickhouse

| Имя таска | Описание |
|--------------|---------|
| `Clickhouse \| Download` | Скачивание пакетов. Используется цикл с перменными `clickhouse_packages`. Так как не у всех пакетов есть `noarch` версии, используем перехват ошибки `rescue` |
| `Clickhouse \| Install` | Установка пакетов, вызов обработчика `Start clickhouse service` через `notify` |
| `Clickhouse \| Create clickhouse config` | Применение шаблона конфига `clickhouse` |
| `Clickhouse \| Flush handlers` | Принудительное выполнение handler `Start clickhouse service` |
| `Clickhouse \| Create database` | Создание БД с названием **logs** и указание условий изменения состояния таска |

### play_install_vector

Применяется на группу хостов "vector", предназначен для установки, конфигурирования и запуска `vector`

Обработчик (handler) для запуска `vector`, таски обращаются к нему через ключ **notify: Start Vector service**
```yaml
  handlers:
    - name: Start Vector service
      become: true
      become_method: su
      become_user: root
      ansible.builtin.service:
        name: vector
        state: restarted
```

### tasks_play_install_vector

| Имя таска | Описание |
|--------------|---------|
| `Vector \| Download` | Скачивание пакета |
| `Vector \| Install` | Установка пакета |
| `Vector \| Apply template` | Применение шаблона конфига `vector` и валидация |
| `Vector \| Change systemd unit` | Изменение модуля службы `vector` |
| `Vector \| Pause for 10 seconds to create vector service` | Пауза в 10 секунд для обноления systemctl `vector` и вызов обработчика `Start Vector service` через `notify` |

## Template

Шаблон "vector.service.j2" используется для изменения модуля службы `vector`. В нем определена строка запуска `vector` и пользователь для запуска

Шаблон "vector.yml.j2" используется для настройки конфига `vector`. Указывает на расположение конфига в переменной "vector_config" и необходимость преобразования в `YAML`