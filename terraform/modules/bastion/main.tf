resource "yandex_compute_instance" "bastion" {
  name        = "bastion"
  platform_id = var.platform_id
  zone        = var.zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id           = var.subnet_id
    nat                 = true
    nat_ip_address      = null
    security_group_ids  = [var.sg_id]
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key_path)}"
  }
}
