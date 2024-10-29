# Домашнее задание к занятию 1 «Введение в Ansible»

## Подготовка к выполнению

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/master/08-ansible-01-base/Screen/Image000.png)

## Основная часть

1. Запуск из окружения `test`: ```ansible-playbook -i inventory/test.yml site.yml```

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/master/08-ansible-01-base/Screen/Image001.png)

2. Файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение: `group_vars/all/examp.yml`

Проведена замена на **all default fact**

```
---
#  some_fact: 12
  some_fact: all default fact
```

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/master/08-ansible-01-base/Screen/Image002.png)

3. Мы же умеем пользоваться docker compose, с его помощью можно подготовить тестовое окружение с образами centos и ubuntu. Для ansible нужен интерпретатор python, которого нет в стандартном образе ubuntu. Нужно собрать свой образ и установить python3 в noninteractive режиме. Соответственно, в проекте появляются новые файлы: compose.yaml для инфраструктуры и Dockerfile для сборки образа

4. Запуск playbook из окружения `prod`:

```
ansible-playbook -i inventory/prod.yml site.yml
```

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/master/08-ansible-01-base/Screen/Image003.png)

5. Замена в `group_vars/el/examp.yml` и `group_vars/deb/examp.yml`

```
---
#  some_fact: "el"
  some_fact: "el default fact"---
```

```
---
#  some_fact: "deb"
  some_fact: "deb default fact"
```

6. Повторный запуск playbook из окружения `prod`:

```
ansible-playbook -i inventory/prod.yml site.yml
```

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/master/08-ansible-01-base/Screen/Image004.png)

7. Шифрование `group_vars/deb` и `group_vars/el` с паролем `netology`

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/master/08-ansible-01-base/Screen/Image005.png)

Содержимое файлов:

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/master/08-ansible-01-base/Screen/Image006.png)

8. Повторный запуск с зашифрованными файлами и запросом пароля (ключ **--ask-vault-pass**):

```
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
```

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/master/08-ansible-01-base/Screen/Image007.png)

9. Запуск `ansible-doc` с ключом `-t connection` (определение типа плагинов из доступных `become`, `cache`, `callback`, `cliconf`, `connection`, `httpapi`, `inventory`, `lookup`, `netconf`, `shell`, `vars`, `module`, `strategy`, `test`, `filter`, `role`, `keyword`), вывод списком `-l` и grep по слову control

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/master/08-ansible-01-base/Screen/Image008.png)

10. В `prod.yml` добавлена новая группа хостов с именем `local` с localhost

```
  local:
    hosts:
      localhost:
        ansible_host: localhost
        ansible_connection: local
```

11. Повторный запуск с зашифрованными файлами, запросом пароля и добавленным localhost

```
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
```
![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/master/08-ansible-01-base/Screen/Image009.png)