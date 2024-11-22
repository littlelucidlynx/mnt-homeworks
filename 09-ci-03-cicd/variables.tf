####cloud vars
variable "cloud_id" {
  type        = string
  default     = "***"
  description = "cloud id for yc"
}

variable "folder_id" {
  type        = string
  default     = "***"
  description = "folder id for yc"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "default zone in yc"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "default cidr in yc"
}

variable "network_name" {
  type        = string
  default     = "elk_net"
  description = "VPC network name"
}

variable "subnetwork_name" {
  type        = string
  default     = "elk_subnet"
  description = "VPC subnet name"
}

variable "web_default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "default_a"
}

variable "family_os" {
  type = string
#  default = "centos-7"
  default = "centos-stream-9-oslogin"
#  default = "almalinux-9"
  description = "falimly os linux"
}

variable "standart_platform_id" {
  type = string
  default = "standard-v1"
  description = "choosing a platform standard"
}

variable "serial-port-enable" {
  type = number
  default     = 1
}

variable "each_vm" {
  type = list(object({
    vm_name=string
    cpu=number
    ram=number
    disk_volume=number
    core_fraction=number
    type_storage = string
    preemptible = bool
    nat = bool
     }))
    default = [ {vm_name = "nexus", cpu = 2, ram = 4, disk_volume = 20, core_fraction = 20, type_storage = "network-hdd", preemptible = true, nat = true },
                {vm_name = "sonar", cpu = 2, ram = 4, disk_volume = 20, core_fraction = 20, type_storage = "network-hdd", preemptible = true, nat = true }
     ]
}

#Имя пользователя в виртуальной машине вместо стандартного
variable "vm_username" {
  type        = string
  default     = "eurus_cloud"
  description = "Username for vm in Cloud init"
}

#Путь к публичному ключу для подключения к yandex cloud
variable "yc_ssh_key_path" {
  description = "Путь к открытому ключу SSH для подключения к облаку"
  type        = string
  default     = "~/.authorized_key.json"
}