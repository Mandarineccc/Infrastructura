output "instance_id" {
  value = yandex_compute_instance.bastion.id
}

output "instance_ip" {
  value = yandex_compute_instance.bastion.network_interface[0].ip_address
}
