output "private_ip" {
  value = yandex_compute_instance.elasticsearch.network_interface[0].ip_address
}
