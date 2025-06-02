output "kibana_instance_ip" {
  value = yandex_compute_instance.kibana.network_interface[0].ip_address
}

output "public_ip" {
  value = yandex_compute_instance.kibana.network_interface[0].nat_ip_address
}

output "disk_id" {
  value = yandex_compute_instance.kibana.boot_disk[0].disk_id
}
