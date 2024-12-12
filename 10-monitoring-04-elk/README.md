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

- скриншот `docker ps` через 5 минут после старта всех контейнеров (их должно быть 5);

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-04-elk/Screen/docker.containers.png)

- скриншот интерфейса kibana;

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-04-elk/Screen/kibana.png)

## Задание 2

Перейдите в меню [создания index-patterns в kibana](http://localhost:5601/app/management/kibana/indexPatterns/create) и создайте несколько index-patterns из имеющихся

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-04-elk/Screen/index.pattern.png)

Перейдите в меню просмотра логов в kibana (Discover) и самостоятельно изучите, как отображаются логи и как производить поиск по логам.

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-04-elk/Screen/discover.png)

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-04-elk/Screen/expand.png)

Фильтрация по полю agent.id

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-04-elk/Screen/agent.id.png)
