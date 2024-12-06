data "yandex_compute_image" "gitlab_server" {
  family = var.family_os_server
}

data "yandex_compute_image" "gitlab_runner" {
  family = var.family_os_runner
}
