# Домашнее задание к занятию 12 «GitLab»

## Подготовка к выполнению

Инфраструктура

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-06-gitlab/Screen/yc.compute.instance.png)

4. Создайте свой новый проект.
5. Создайте новый репозиторий в GitLab, наполните его [файлами](./repository).
6. Проект должен быть публичным, остальные настройки по желанию.

## Основная часть

### DevOps

Создан проект, наполнен файлами. При коммите в ветку main образ пушится в yandex cloud registry

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-06-gitlab/Screen/pipeline.passed.png)

Часть лога пайплайна

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-06-gitlab/Screen/job.succeeded.png)

Список образов в yandex cloud registry

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-06-gitlab/Screen/yc.images.png)

### Product Owner

Создан Issue

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-06-gitlab/Screen/issue.board.png)

Подробное описание Issue

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-06-gitlab/Screen/issue.png)

### Developer

Создана отдельная ветка `issue-branch`

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-06-gitlab/Screen/new.branch.png)

Внесены изменения, выполнен коммит, пайплайн выполняет сборку без выгрузки образа в yandex cloud registry

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-06-gitlab/Screen/build.without.deploy.png)

Создан merge с веткой main

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-06-gitlab/Screen/merge.changes.png)

Выполнен merge с веткой main

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-06-gitlab/Screen/merged.png)

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-06-gitlab/Screen/merge.done.png)

Новый контейнер в yandex cloud registry

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-06-gitlab/Screen/yc.images+.png)

### Tester

Тест в докере нового метода

```yaml
docker run --rm -d -p 5290:5290 --name python-api cr.yandex/crpuvi2ap35vrrkq5a1t/hello:gitlab-c4201634
curl http://localhost:5290/get_info
```

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-06-gitlab/Screen/result.png)

Закрытие Issue

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-06-gitlab/Screen/issue.closed.png)

## Итог

В качестве ответа пришлите подробные скриншоты по каждому пункту задания:

- [файл .gitlab-ci.yml](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-06-gitlab/.gitlab-ci.yml)
- [Dockerfile](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-06-gitlab/Dockerfile)
- [лог пайплайна](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/09-ci-06-gitlab/pipeline_log.txt)
