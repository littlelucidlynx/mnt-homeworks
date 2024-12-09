# Домашнее задание к занятию 14 «Средство визуализации Grafana»

### Задание 1

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-03-grafana/Screen/grafana.datasources.png)

## Задание 2

- утилизация CPU для nodeexporter (в процентах, 100-idle);
```yaml
100 - (avg by(instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)
```

- CPULA 1/5/15;
```yaml
node_load1
node_load5
node_load15
```

- количество свободной оперативной памяти;
```yaml
node_memory_MemFree_bytes
```

- количество места на файловой системе.
```yaml
node_filesystem_avail_bytes{device="/dev/root", fstype="erofs", instance="nodeexporter:9100", job="nodeexporter", mountpoint="/"}
```

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-03-grafana/Screen/grafana.dashboard.png)

## Задание 3

Создам канал оповещения `telegram`. Делал подобное в zabbix - ничего сложного. Нужно создать бота, добавить его в чат и внести их ID в grafana. У панелей, там, где это доступно, настроены алерты - появились сердечки

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-03-grafana/Screen/grafana.dashboard.alerts.png)

Срабатывающие уведомления отправляются в чат через бота

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-03-grafana/Screen/telegram.alerts.png)

Оказывается, не на всех типах графиков можно настроить алерты. В заббиксе как-то все очевиднее. Там каналу оповещения сопоставляется триггер, который срабатывает независимо от наличия дашбордов и типов графика

## Задание 4

[dashboard.json](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-03-grafana/dashboard.json)
