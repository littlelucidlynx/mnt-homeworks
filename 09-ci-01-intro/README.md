# Домашнее задание к занятию 7 «Жизненный цикл ПО»

## Подготовка к выполнению

1. Настроена self-hosted jira из контейнеров с jira и postgresql. Предложенный образ не умеет поднимать собственную внутреннюю базу и не дружит с mysql даже после установки драйвера. Ну и ладно, сделаю на postgresql.
2. Получен триальный доступ к jira.
3. Создан проект example-netology-01 и доски Kanban EX01 и Scrum EX1.
![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-01-intro/Screen/Image000.png)

## Основная часть

Необходимо создать собственные workflow для двух типов задач: bug и остальные типы задач. Задачи типа bug должны проходить жизненный цикл:

[workflow для bug](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-01-intro/bug.xml)

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-01-intro/Screen/Image003.png)

1. Open -> On reproduce.
2. On reproduce -> Open, Done reproduce.
3. Done reproduce -> On fix.
4. On fix -> On reproduce, Done fix.
5. Done fix -> On test.
6. On test -> On fix, Done.
7. Done -> Closed, Open.

[workflow для other tasks](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-01-intro/other_tasks.xml)

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-01-intro/Screen/Image004.png)

1. Open -> On develop.
2. On develop -> Open, Done develop.
3. Done develop -> On test.
4. On test -> On develop, Done.
5. Done -> Closed, Open.

**Что нужно сделать**

1. Панель Kanban после выполнения задач
![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-01-intro/Screen/Image001.png)
2. Отчет после закрытия спринта
![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-01-intro/Screen/Image002.png)
