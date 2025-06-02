output "private_ip" {
  value = yandex_compute_instance.elasticsearch.network_interface[0].ip_address
}

output "disk_id" {
  value = yandex_compute_instance.elasticsearch.boot_disk[0].disk_id
}
