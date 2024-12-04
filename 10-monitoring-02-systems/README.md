# Домашнее задание к занятию "13.Системы мониторинга"

## Обязательные задания

1. Приложение, которое нагружает вычислениями ЦП, пишет отчеты на диск и отдает себя по http.

- Базовые метрики для мониторинга дисковой подсистемы позволят выявить аномалии нагрузки, а так же предупредить о деградации и переполнении:
  - utilization - общая нагрузка на устройство;
  - текущая скорость чтения/записи в Кб/с;
  - iops - количество операций чтения/записи в секунду;
  - latency - задержка обработки запроса;
  - total space - общий размер диска;
  - used space - размер занятого места на диске;
  - free inodes % - свободные индексные дескрипторы.

- Базовые метрики центрального процессора позволят выявить аномальную загрузку процессора, а в связке метриками дисковой подсистемы позволят определить узкое место:
  - load average - средняя нагрузка;
  - cpu iowait - время ожидания в очереди.

- Базовые метрики оперативной памяти:
  - available memory in % - процент свободной доступной памяти;
  - free swap space in % - процент свободного места в свопе.

- Базовые метрики сети позволят выявить аномальную нагрузку, а график визуализирует периоды всплесков:
  - incoming/outgoing packets per time - количество принятых/переданных пакетов в единицу времени;
  - incoming/outgoing dropped packets per time - количество отброшенных пакетов в единицу времени.

- Базовые метрики приложения:
  - статус службы приложения;
  - статус службы веб-сервера;
  - количество http запросов;
  - количество активных и отброшенных соединений;
  - количество ошибок по кодам ответов.

2. Менеджеру важны не сами технические показатели, а то как они связываются с бизнес составляющей. Необходимо выявить индикаторы качества обслуживания (SLI), задать их целевой уровень (SLO) и оформить соглашение/контракт с пользователем (SLA), определяющий санкции за невыполнение SLO. Проще говоря, "как понять, что оно работает, сколько оно может не работать, и что нам за это будет".

3. Если нет бюджета на систему сбора логов, а данные нужны - можно использовать облачные версии перехватчиков ошибок вроде `Sentry` и `Glitchtip`

4. В формуле `summ_2xx_requests/summ_all_requests` учитывается только отношение кодов ответов `2xx (Success)` к общему числу кодов ответов, без учета кодов `1xx (Informational)` и `3xx (Redirection)`. Вариант корректной формулы: `(summ_1xx_requests)+(summ_2xx_requests)+(summ_3xx_requests)/summ_all_requests`

5. Опишите основные плюсы и минусы pull и push систем мониторинга.

  - `push` - источник отправляет данные в систему мониторинга. Подходит для систем с большим числом узлов (в т.ч. расположенных за NAT) и определенной периодичностью получения данных. Основную нагрузку берет на себя агент на узле, снижая нагрузку на систему мониторинга => упрощается масштабирование (применение прокси и балансировщиков нагрузки). Проще в развертывании. Сложнее диагностировать недоступность ноды.
  - `pull` - система мониторинга запрашивает данные у источника. Подходит для более тонкой настройки мониторинга, требует реверс-прокси, настройки файерволла и экспортера. Основная нагрузка выполняется на сервере мониторинга => масштабирование сводится к установке более мощной ноды или горизонтальному (федеративному) масштабированию. Сложнее в развертывании. Проще обнаружить недоступность ноды.

6. Какие из ниже перечисленных систем относятся к push модели, а какие к pull? А может есть гибридные?

  - Prometheus - изначально pull, но можно добавить push-gateway
  - TICK - push
  - Zabbix - гибрид push и pull
  - VictoriaMetrics - гибрид push и pull
  - Nagios - push

7. Склонируйте себе [репозиторий](https://github.com/influxdata/sandbox/tree/master) и запустите TICK-стэк, используя технологии docker и docker-compose

`./sandbox up`

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-02-systems/Screen/chronograf.png)

8. Перейдите в веб-интерфейс Chronograf (http://localhost:8888) и откройте вкладку Data explorer.

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-02-systems/Screen/telegraf.autogen.png)

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-02-systems/Screen/telegraf.autogen.cpu.png)

9. Кусок конфигурации `telegraf.conf` с докером:

```yaml
[[inputs.docker]]
  endpoint = "unix:///var/run/docker.sock"
  gather_services = false
  source_tag = false
  container_name_include = []
  container_name_exclude = []
  storage_objects = []
  timeout = "5s"
  perdevice_include = ["cpu"]
  total = false
  docker_label_include = []
  docker_label_exclude = []
  tag_env = ["JAVA_HOME", "HEAP_SIZE"]
```
Исправленый `docker-compose.yml`

```yaml
  telegraf:
    build:
      context: ./images/telegraf/
      dockerfile: ./${TYPE}/Dockerfile
      args:
        TELEGRAF_TAG: ${TELEGRAF_TAG}
    image: "telegraf:1.4.0"
    privileged: true
    environment:
      HOSTNAME: "telegraf-getting-started"
    links:
      - influxdb
    ports:
      - "8092:8092/udp"
      - "8094:8094"
      - "8125:8125/udp"
    volumes:
      - ./telegraf/telegraf.conf:/etc/telegraf/telegraf.conf:Z
      - /var/run/docker.sock:/var/run/docker.sock:Z
    depends_on:
      - influxdb
```

![Image alt](https://github.com/littlelucidlynx/mnt-homeworks/blob/MNT-video/10-monitoring-02-systems/Screen/telegraf.docker.png)
