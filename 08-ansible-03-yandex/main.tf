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
  %{if length(yandex_compute_instance.ansible-instance) > 0}
  %{endif}
  %{for i in yandex_compute_instance.ansible-instance }
${i["name"]}:
  hosts:
    ${i["name"]}-01: 
      ansible_host: ${i["network_interface"][0]["nat_ip_address"]}
      ansible_user: eurus_cloud
  %{endfor}
  EOT
#Расположение файла inventory в проекте
  filename = "./playbook/inventory/prod.yml"
}