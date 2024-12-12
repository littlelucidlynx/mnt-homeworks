# Домашнее задание к занятию 15 «Система сбора логов Elastic Stack»

## Дополнительные ссылки

При выполнении задания используйте дополнительные ресурсы:

- [поднимаем elk в docker](https://www.elastic.co/guide/en/elastic-stack-get-started/current/get-started-docker.html);
- [поднимаем elk в docker с filebeat и docker-логами](https://www.sarulabs.com/post/5/2019-08-12/sending-docker-logs-to-elasticsearch-and-kibana-with-filebeat.html);
- [конфигурируем logstash](https://www.elastic.co/guide/en/logstash/current/configuration.html);
- [плагины filter для logstash](https://www.elastic.co/guide/en/logstash/current/filter-plugins.html);
- [конфигурируем filebeat](https://www.elastic.co/guide/en/beats/libbeat/5.3/config-file-format.html);
- [привязываем индексы из elastic в kibana](https://www.elastic.co/guide/en/kibana/current/index-patterns.html);
- [как просматривать логи в kibana](https://www.elastic.co/guide/en/kibana/current/discover.html);
- [решение ошибки increase vm.max_map_count elasticsearch](https://stackoverflow.com/questions/42889241/how-to-increase-vm-max-map-count).

## Задание 1

- скриншот `docker ps`

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-04-elk/Screen/docker.containers.png)

- скриншот интерфейса `kibana`

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-04-elk/Screen/kibana.png)

## Задание 2

data view: `log`

index pattern: `logstash-*`

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-04-elk/Screen/index.pattern.png)

Просмотр логов по индекс-паттерну за 120 минут

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-04-elk/Screen/discover.png)

Расширенный вид документа

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-04-elk/Screen/expand.png)

Выбор поля `agent.id` для отображения

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-04-elk/Screen/agent.id.png)

Фильтр по полю message

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-04-elk/Screen/sort.by.message.png)