# Домашнее задание к занятию 3 «Использование Ansible»

## Подготовка к выполнению

1. Версия ansible

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-03-yandex/Screen/Image000.png)

2. Версия terraform и yc

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-03-yandex/Screen/Image001.png)

## Основная часть

1. centos7 поддерживает vector до версии `0.22.3` включительно. С этой оговоркой можно разворачивать стенд
2. Виртуальные машины проводятся через terraform, создание группы безопасности для сети взято из предыдущих заданий
3. Смена имени пользователя по умолчанию, установка ssh-ключа через `cloud-init.yml`. Файл включен в `.gitignore`
4. inventory-файл `prod.yml` будет формироваться из ресурса **yandex_compute_instance.ansible-instance**

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-03-yandex/Screen/Image002.png)

5. Запуск `tflint` и `ansible-lint site.yml`

Ошибки terraform:
- Не объявлены версии провайдеров yandex-cloud/yandex и hashicorp/local
- Переменные объявлены, но не используются

Ошибки ansible:
- Имя task со строчной буквы
- Для встроенного модуля использовано короткое имя вместо полного имени коллекции
- Отсутствует пустая строка в конце файла
- Указано неявное восьмеричное значение
- Commands should not change things if nothing needs doing - **игнориуем**

Ошибки исправлены

6.  При запуске с флагом `--check` возникает ошибка в таске установки clickhouse, поскольку `--check` выполняет только проверку, но не сами действия. Соответственно, он не скачивает дистрибутив в предыдущем таске

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-03-yandex/Screen/Image008.png)

7. Первый запуск на `prod.yml` окружении с флагом `--diff`

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-03-yandex/Screen/Image003.png)

8. Повторный запуск playbook с флагом `--diff` — изменений нет, playbook идемпотентен

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-03-yandex/Screen/Image004.png)

9. Результаты

Clickhouse - подключение по ssh и запуск `clickhouse-client -h 127.0.0.1`
![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-03-yandex/Screen/Image005.png)

Vector - подключение по ssh, вывод списка файлов и содержимое `vector.yml`
![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-03-yandex/Screen/Image006.png)

Lighthouse - http по публичному адресу
![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-03-yandex/Screen/Image007.png)

10. Ссылка на [Readme.md](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-03-yandex/playbook/Readme.md) с описанием Playbook
