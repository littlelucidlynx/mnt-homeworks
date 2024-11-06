resource "yandex_compute_instance" "ansible-instance" {
  for_each = tomap({for i in var.each_vm : i.vm_name => i})
    name = each.value.vm_name  
    hostname = each.value.vm_name
  zone = var.web_default_zone
  platform_id = var.standart_platform_id

    resources {
      cores = each.value.cpu
      memory = each.value.ram
      core_fraction = each.value.core_fraction
    }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.db.image_id
      type     = each.value.type_storage
      size     = each.value.disk_volume
    }
  }
  scheduling_policy {
    preemptible = each.value.preemptible
  }
  network_interface {
    subnet_id           = yandex_vpc_subnet.elk_subnetwork.id
    nat                 = each.value.nat
    security_group_ids  = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = var.serial-port-enable
#    ssh-keys           = "ubuntu:${var.ssh_key_for_any_host.ssh-keys}" 
#    ssh-keys           = local.vms_ssh_root_key 
#    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    user-data          = file("./cloud-init.yml")
  }
}
