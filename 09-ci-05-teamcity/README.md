# Домашнее задание к занятию 11 «Teamcity»

## Подготовка к выполнению

1. Инфраструктура в Yandex Cloud

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-05-teamcity/Screen/yc_compute_instance_list.png)

2. Авторизация агента

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-05-teamcity/Screen/authorize_agent.png)

3. fork [репозитория](https://github.com/littlelucidlynx/example-teamcity.git)

4. Запуск слегка измененного `playbook` на хосте с `nexus`

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-05-teamcity/Screen/ansible_playbook.png)


## Основная часть

1. Новый проект на основе fork [репозитория](https://github.com/littlelucidlynx/example-teamcity.git)

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-05-teamcity/Screen/project_creation.png)

2. autodetect конфигурации - `Maven`

3. Первая сборка `master`

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-05-teamcity/Screen/1_build.png)

4. Изменение условий сборки: если сборка по ветке `master`, то должен происходит `clean deploy`, иначе `clean test`

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-05-teamcity/Screen/build_steps.png)

5. Загрузка `settings.xml` в набор конфигураций `maven`

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-05-teamcity/Screen/custom_settings.png)

6. Измененный `pom.xml` версии `0.0.1`

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-05-teamcity/Screen/pom_xml_0.0.1.png)

7. Запуск сборки по `master`, артефакт в `nexus`

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-05-teamcity/Screen/2_build.png)

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-05-teamcity/Screen/nexus_artifact_0.0.1.png)

8. Для [build configuration](https://github.com/littlelucidlynx/example-teamcity/tree/master/.teamcity/Test) создал вручную отдельный проект, привязал к нему VCS по ssh, а затем уже добавил проект из репозитория. Иначе github не принимал коммиты по https

9. Отдельная ветка `feature/add_reply` в репозитории

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-05-teamcity/Screen/new_branch.png)

10. Новый метод для класса `Welcomer`: метод должен возвращать произвольную реплику, содержащую слово `hunter`

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-05-teamcity/Screen/welcomer.png)

11. Дополнительный тест для нового метода на поиск слова `hunter`

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-05-teamcity/Screen/welcomer_test.png)

12. Сборки самостоятельно запускаются. На #5 добавлено формирование артефакта в teamcity, pom.xml исправлен не был. На #6 teamcity попытался записать имеющийся артефакт в nexus, но не смог. На ошибку можно не обращать внимания

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-05-teamcity/Screen/all_builds.png)

13. Сборка с тестовой ветки без деплоя

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-05-teamcity/Screen/build_nomaster_log.png)

14. Артефакта нет

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-05-teamcity/Screen/build_nomaster_artifacts.png)

15. Конфигурация для сборки `.jar` в артефакты при условии успешного завершения билда

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-05-teamcity/Screen/jar_artifacts.png)

16. Повторная сборка мастера с деплоем

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-05-teamcity/Screen/build_master_log.png)

17. Артефакты в `teamcity` и `nexus`

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-05-teamcity/Screen/build_master_artifacts.png)

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-05-teamcity/Screen/nexus_artifacts.png)
