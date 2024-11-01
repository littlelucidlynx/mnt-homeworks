# Домашнее задание к занятию 2 «Работа с Playbook»

## Подготовка к выполнению

1. Так как clickhouse и vector не являются основной темой этого задания, то их работоспособной связкой я заниматься не буду. Просто подниму их как сервисы и оставлю для самостоятельного изучения
2. ![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-02-playbook/Screen/Image000.png)
3. Хосты

```
---
clickhouse:
  hosts:
    clickhouse-01:
      ansible_connection: docker
vector:
  hosts:
    vector-01:
      ansible_connection: docker

```

## Основная часть

1. Подготовьте свой inventory-файл `prod.yml`.
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev). Конфигурация vector должна деплоиться через template файл jinja2. От вас не требуется использовать все возможности шаблонизатора, просто вставьте стандартный конфиг в template файл. Информация по шаблонам по [ссылке](https://www.dmosk.ru/instruktions.php?object=ansible-nginx-install). не забудьте сделать handler на перезапуск vector в случае изменения конфигурации!
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.
5. Запуск `ansible-lint site.yml`

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-02-playbook/Screen/Image001.png)

Ошибки:
`Не задано имя task`
`Не заданы права на файл`
`Для встроенного модуля использовано короткое имя вместо полного имени коллекции`
`Отсутствует пустая строка в конце файла`

Предупреждения:
`Неподдерживаемый параметр`
`Отсутствие пробела в шаблоне`

Исправление и повторный запуск `ansible-lint site.yml`

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-02-playbook/Screen/Image002.png)

6. При запуске с флагом `--check` возникает ошибка в таске установки clickhouse, поскольку `--check` не выполняет скачивание в предыдущем таске, и фактически файла нет

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-02-playbook/Screen/Image003.png)

7. Первый запуск на `prod.yml` окружении с флагом `--diff`

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-02-playbook/Screen/Image004.png)

8. Повторный запуск playbook с флагом `--diff`  — изменений нет, playbook идемпотентен

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-02-playbook/Screen/Image004.png)

9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги. Пример качественной документации ansible playbook по [ссылке](https://github.com/opensearch-project/ansible-playbook). Так же приложите скриншоты выполнения заданий №5-8
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
