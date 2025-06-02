output "bastion_public_ip" {
  value = yandex_compute_instance.bastion.network_interface[0].nat_ip_address
}

output "bastion_instance_id" {
  value = yandex_compute_instance.bastion.id
}

output "disk_id" {
  value = yandex_compute_instance.bastion.boot_disk[0].disk_id
}
