# Домашнее задание к занятию 9 «Процессы CI/CD»

## Подготовка к выполнению

0. Плотину нужно поднять. Рычагом. Я его дам. Канал нужно завалить. Камнем. Камень я не дам

1. Создать ВМ в Yandex Cloud не сложно, но есть несколько но:

- Текущая версия `ansible [core 2.17.6]` требует интерпретатор python версии 3.7 и выше (для некоторых модулей это критично);
- Официальные репозитории centos7 и centos8 более недоступны. Можно добавить сторонние, но ситуацию это сильно не изменит;
- Текущая версия `ansible [core 2.17.6]` не распознает контекст пакетных менеджеров yum (centos7) и dnf (centos8) даже с принудительным указанием `use_backend`;

Желание немного поразбираться и облегчить другим работу взяло верх. Как же в итоге сделал я?

- Поскольку изначальный playbook ориентирован на RHEL-based дистрибутив, то я взял актуальный **centos-stream-9-oslogin** (можно заменить на **almalinux-9**)
- Переделал playbook с `ansible.builtin.yum` на `ansible.builtin.dnf` с добавлением `disable_gpg_check: true`
- Убрал установку репозитория postgresql**11**. Вместо него будет использоваться postgresql**14**. Так же необходимо поправить пути установки конфигов с 11 на 14 версию
- Заменил строки запуска и остановки `nexus`, иначе он не поднимется

```yaml
#ExecStart={{ nexus_directory_home }}/bin/nexus start
#ExecStop={{ nexus_directory_home }}/bin/nexus stop
ExecStart=/bin/bash {{ nexus_directory_home }}/bin/nexus start
ExecStop=/bin/bash {{ nexus_directory_home }}/bin/nexus stop
```
- Inventory-файл `hosts.yml` переименовал в `hosts_old.yml`. Актуальный динамический inventory мне будет формировать terraform
- Добавил создание группы безопасности шаблоном из предыдущих домашних заданий, дополнительно включив разрешение входящего трафика `TCP/IP 8081` и `TCP/IP 9000` с любых внешних хостов
- Взял свежую версию `nexus 3.74.0-05`
- Добавил в playbook отдельную таску на очистку локального файла `~/.ssh/known_hosts`
- Добавил в проект на уровень infrastructure файл `ansible.cfg` для отключения проверки отпечатков ssh-ключей

Стенд поднялся. В целом, не то чтобы сложно. Возможно, будущим студентам это облегчит выполнение домашней работы и позволит изучить сам инструментарий, а не решать проблемы совместимости

2. Готовность SonarQube через браузер

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-03-cicd/Screen/SonarQube_start_page.png)

3. Готовность Nexus через бразуер

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-03-cicd/Screen/Nexus_start_page.png)

4. Nexus сам подсказал где взять дефолтный пароль для админа

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-03-cicd/Screen/Nexus_default_password.png)

5. Сохранил анонимный доступ

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-03-cicd/Screen/Nexus_anon_access.png)

## Знакомоство с SonarQube

### Основная часть

1. Создан новый локальный проект `example-netology-01`, получен токен

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-03-cicd/Screen/SonarQube_create_project.png)

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-03-cicd/Screen/SonarQube_token.png)

2. sonar-scanner установлен через brew

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-03-cicd/Screen/Sonar-scanner_version.png)

3. Натравливание **sonar-scanner** на `./example` с дополнительным ключом

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-03-cicd/Screen/Sonar-scanner_run.png)

4. Результаты в интерфейсе

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-03-cicd/Screen/SonarQube_1_check.png)

5. Баги

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-03-cicd/Screen/SonarQube_bugs.png)

6. Исправление, повторный анализ

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-03-cicd/Screen/SonarQube_2_check.png)

## Знакомство с Nexus

### Основная часть

1. В репозиторий `maven-public` загружены два артефакта (один и тот же пустой файл с расширением **.tar.gz**)

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-03-cicd/Screen/Nexus_repo_artifacts.png)

2. Итоговый [maven-metadata.xml](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-03-cicd/maven_metadata.xml) для этого артефекта

### Знакомство с Maven

### Подготовка к выполнению

1. maven установлен через brew

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-03-cicd/Screen/Mvn_version.png)

2. Из `/usr/local/Cellar/maven/3.9.9/libexec/conf/settings.xml` удалено упоминание блокировки http

### Основная часть

1. Измененный файл `pom.xml` с блоком с зависимостями под артефакт **java** с версией **8_282**

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-03-cicd/Screen/Mvn_version.png)

2. Запуск команды `mvn package` в директории с `pom.xml`, просмотр наличия артефакта в директории `~/.m2/repository/netology/java/8_282/`

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-03-cicd/Screen/Mvn_artifact.png)

3. Итоговый [pom.xml](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-03-cicd/mvn/pom.xml)

---