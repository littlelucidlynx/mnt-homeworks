# Описание site.yml playbook

Плейбук описывает развертывание `clickhouse`, `vector` и `lighthouse` на хосты, указанные в `inventory`

- [group_vars clickhouse](#group_vars_clickhouse)
- [group_vars vector](#group_vars_vector)
- [Inventory](#inventory)
- [Playbook](#playbook)
  - [Play "Install Clickhouse"](#play_install_clickhouse)
  - [Tasks Play "Install Clickhouse"](#tasks_play_install_clickhouse)
  - [Play "Install Vector"](#play_install_vector)
  - [Tasks Play "Install Vector"](#tasks_play_install_vector)
  - [Play "Install Lighthouse"](#play_install_lighthouse)
  - [Tasks Play "Install Lighthouse"](#tasks_play_install_lighthouse)  
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
| `lighthouse_access_log_name` | имя файла логов |
| `nginx_user_name` | имя пользователя `nginx` |

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

### play_install_vector

Применяется на группу хостов "vector", предназначен для установки, конфигурирования и запуска `vector`

Обработчик (handler) для запуска `vector`, таски обращаются к нему через ключ **notify: Start Vector service**
```yaml
  handlers:
    - name: Start Vector Service
      become: true
      ansible.builtin.systemd:
        name: vector
        state: started
        daemon_reload: true
```

### tasks_play_install_vector

| Имя таска | Описание |
|--------------|---------|
| `Vector \| Download` | Скачивание пакета |
| `Vector \| Install` | Установка пакета |
| `Vector \| Apply template` | Применение шаблона конфига `vector` и валидация |
| `Vector \| Change systemd unit` | Изменение модуля службы `vector` |
| `Vector \| Change systemd unit` | Изменение модуля службы `vector` |
| `Vector \| Pause for 10 seconds` | Пауза в 10 секунд для обноления systemctl `vector` и вызов обработчика `Start Vector Service` через `notify` |
| `Vector \| Flush handlers` | Принудительное выполнение handler `Start Vector Service` |


### play_install_lighthouse

Применяется на группу хостов "lighthouse", предназначен для установки, конфигурирования и запуска `lighthouse`

Обработчики (handler) для запуска и перезапуска `Nginx`, таски обращаются к нему через ключи **notify: Start-nginx** и **notify: Reload-nginx**

```yaml
 handlers:
    - name: Start-nginx
      become: true
      ansible.builtin.command: nginx
    - name: Reload-nginx
      become: true
      ansible.builtin.command: nginx -s reload
```
### tasks_play_install_lighthouse

| Имя пре-таска | Описание |
|--------------|---------|
| `Lighthouse \| Install dependencies` | Установка `git` |
| `Lighhouse \| Install epel-release` | Добавление `epel-release` |
| `Lighhouse \| Install nginx` | Установка `Nginx` и вызов обработчика `Start-nginx` через `notify`|
| `Lighthouse \| Create general config` | Создание конфига `Nginx` и вызов обработчика `Reload-nginx` через `notify` |

| Имя таска | Описание |
|--------------|---------|
| `Lighthouse \| Copy from git` | Клонирование репозитория `lighthouse` |
| `Lighthouse \| Create lighthouse config` | Создание конфига `Nginx` для `lighthouse`. После этого перезапускаем `nginx` и вызов обработчика `Reload-nginx` через `notify`  |

## Template

Шаблон "vector.service.j2" используется для изменения модуля службы `vector`. В нем мы определяем строку запуска `vector`. Также указываем, что unit должен быть запущен под текущим пользователем `ansible`

Шаблон "vector.yml.j2" используется для настройки конфига `vector`. В нем мы указываем, что конфиг файл находится в переменной "vector_config" и его надо преобразовать в `YAML`.

Шаблон "nginx.conf.j2" используется для первичной настройки `nginx`. Мы задаем пользователя для работы `nginx` и удаляем настройки root директории по умолчанию.

Шаблон "lighthouse_nginx.conf.j2" настраивает `nginx` на работу с `lighthouse`. В нем прописываем порт 80, root директорию и index страницу.