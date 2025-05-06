terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
    }
  }
}

resource "yandex_compute_instance" "kibana" {
  name        = "kibana-server"
  platform_id = var.platform_id
  zone        = var.zone  # Исправлено с zone_1 на zone (как объявлено в variables.tf)

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 10
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
    security_group_ids = [var.sg_id]  # Добавлено использование security group
  }

  metadata = {
    user-data = <<-EOT
      #cloud-config
      packages:
        - kibana
      runcmd:
        - systemctl enable kibana --now
    EOT
  }
}