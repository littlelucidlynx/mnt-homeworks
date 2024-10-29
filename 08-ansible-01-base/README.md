# Домашнее задание к занятию 1 «Введение в Ansible»

## Подготовка к выполнению

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-01-base/Screen/Image000.png)

1. Установите Ansible версии 2.10 или выше.
2. Создайте свой публичный репозиторий на GitHub с произвольным именем.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.

## Основная часть

1. Запуск из окружения test: ```ansible-playbook -i inventory/test.yml site.yml```

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-01-base/Screen/Image001.png)

2. Файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение: **\playbook\group_vars\all\examp.yml**

Проведена замена на **all default fact**

```
---
#  some_fact: 12
  some_fact: all default fact
```

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-01-base/Screen/Image002.png)

3. Мы же умеем пользоваться docker compose, с его помощью можно подготовить тестовое окружение с образами centos и ubuntu. Для ansible нужен интерпретатор python, которого нет в стандартном образе ubuntu. Нужно собрать свой образ и установить python3 в non-interactive режиме. Соответственно, в проекте появляются новые файлы: compose.yaml для инфраструктуры и Dockerfile для сборки образа.

4. Запуск playbook из окружения **prod**:

```
ansible-playbook -i inventory/prod.yml site.yml
```

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-01-base/Screen/Image003.png)

5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.
6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.
7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.
9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.
10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.
11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.
12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.
13. Предоставьте скриншоты результатов запуска команд.

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот вариант](https://hub.docker.com/r/pycontribs/fedora).
5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.
6. Все изменения должны быть зафиксированы и отправлены в ваш личный репозиторий.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
