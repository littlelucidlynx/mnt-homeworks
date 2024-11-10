# Домашнее задание к занятию 4 «Работа с roles»

## Подготовка к выполнению

1. Репозиторий `Vector`

[Vector](https://github.com/littlelucidlynx/vector-role.git)

2. Репозиторий `Lighthouse`

[Lighthouse](https://github.com/littlelucidlynx/lighthouse-role.git)

3. Публичные части ключей для доступа к профилю на GitHub добавлены

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-04-role/Screen/Image000.png)

## Основная часть

На время тестирования ролей расположу их локально и буду обращаться через `- role: '../vector-role'` и `- role: '../lighthouse-role'`

```yaml
---
- name: Install Clickhouse
  hosts: clickhouse
  roles:
    - role: clickhouse
- name: Install Vector
  hosts: vector
  roles:
    - role: '../vector-role'
- name: Install lighthouse
  hosts: lighthouse
  roles:
    - role: '../lighthouse-role'
```

**Что нужно сделать**

1. Содержимое `requirements.yml` после тестирования ролей и пуша в github:

```yaml
---
  - name: clickhouse
    src: git@github.com:AlexeySetevoi/ansible-clickhouse.git
    scm: git
    version:  "1.13"

  - name: vector-role
    src: git@github.com:littlelucidlynx/vector-role.git
    scm: git
    version: "1.0.0"

  - name: lighthouse-role
    src: git@github.com:littlelucidlynx/lighthouse-role.git
    scm: git
    version: "1.0.0"

```

2. Скачивание всех ролей. Роль `clickhouse` уже присутствует, принудительно скачивать не стал 

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-04-role/Screen/Image001.png)

3. Переменные разделены на `defaults\main.yml` и `vars\main.yml`. Переменные, которые отданы пользователям на изменение, расположил в `defaults\main.yml`
4. Нужные шаблоны конфигов расположил в `templates`
5. По образу и подобию роли `clickhouse` разделил таски на субдиректории `install` и `configure`. В `tasks\main.yml` идет обращение к ним через вложенные таски `- ansible.builtin.include_tasks`. Сделано это, чтобы не смешивать роли и таски
6. Итоговый `playbook`, переработанный под роли. В плейбуке только роли, все таски перенесены внутрь ролей

```yaml
---
- name: Install Clickhouse
  hosts: clickhouse
  roles:
    - role: clickhouse
- name: Install Vector
  hosts: vector
  roles:
    - role: vector-role
- name: Install lighthouse
  hosts: lighthouse
  roles:
    - role: lighthouse-role

```

7. Инфраструктура через terraform

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-04-role/Screen/Image004.png)

8. Выполнение playbook

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-04-role/Screen/Image002.png)

Lighthouse

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/08-ansible-04-role/Screen/Image003.png)
