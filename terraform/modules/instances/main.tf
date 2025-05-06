resource "yandex_compute_instance" "bastion" {
  name         = var.instance_name
  platform_id  = var.platform_id
  subnet_id    = var.subnet_id
  public_ip    = var.public_ip
  security_group = var.security_group

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
  }
}