locals {
#  vms_ssh_root_key = "centos:${file("~/.ssh/service-cloud-ssh.pub")}"
  vms_ssh_root_key = "${var.vm_username}:${file("~/.ssh/service-cloud-ssh.pub")}"
}