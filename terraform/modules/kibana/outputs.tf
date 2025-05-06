output "kibana_instance_ip" {
  value = yandex_compute_instance.kibana.network_interface[0].ip_address
}

output "public_ip" {
  value = yandex_compute_instance.kibana.network_interface[0].nat_ip_address
}
