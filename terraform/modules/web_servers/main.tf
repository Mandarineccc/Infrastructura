resource "yandex_compute_instance" "web_server_1" {
  name     = "web1"
  hostname = "web1"
  zone     = var.zone_1
  platform_id = var.platform_id

  resources {
    cores         = 2
    core_fraction = 20
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 10
    }
  }

  network_interface {
    subnet_id          = var.subnet_ids.zone_1
    nat                = false
    security_group_ids = [var.sg_id]
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key_path)}"
  }
}

resource "yandex_compute_instance" "web_server_2" {
  name     = "web2"
  hostname = "web2"
  zone     = var.zone_2
  platform_id = var.platform_id

  resources {
    cores         = 2
    core_fraction = 20
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 10
    }
  }

  network_interface {
    subnet_id          = var.subnet_ids.zone_2
    nat                = false
    security_group_ids = [var.sg_id]
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key_path)}"
  }
}

resource "yandex_lb_target_group" "web_servers" {
  name = "web-servers-tg"

  target {
    subnet_id = var.subnet_ids["zone_1"]
    address   = yandex_compute_instance.web_server_1.network_interface[0].ip_address
  }

  target {
    subnet_id = var.subnet_ids["zone_2"]
    address   = yandex_compute_instance.web_server_2.network_interface[0].ip_address
  }
}
