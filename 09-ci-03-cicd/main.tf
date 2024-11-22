resource "yandex_vpc_network" "elk_network" {
  name = var.network_name
}

resource "yandex_vpc_subnet" "elk_subnetwork" {
  name           = var.subnetwork_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.elk_network.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "db" {
  family = var.family_os
}

#Создание динамического inventory
resource "local_file" "hosts_for" {
    depends_on = [ yandex_compute_instance.ansible-instance ]
content =  <<-EOT
---
local:
  hosts:
    localhost:
      ansible_host: localhost
      ansible_connection: local
project:
  hosts:%{if length(yandex_compute_instance.ansible-instance) > 0}%{endif}%{for i in yandex_compute_instance.ansible-instance }
    ${i["name"]}-01:
      ansible_host: ${i["network_interface"][0]["nat_ip_address"]}%{endfor}
  children:
    sonarqube:
      hosts:
        sonar-01:
    nexus:
      hosts:
        nexus-01:
    postgres:
      hosts:
        sonar-01:
  vars:
    ansible_connection_type: paramiko
    ansible_user: eurus_cloud
EOT
#Расположение файла inventory в проекте
  filename = "./infrastructure/inventory/cicd/hosts.yml"
}