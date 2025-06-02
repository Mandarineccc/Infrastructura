output "web_server_1_ip" {
  value = yandex_compute_instance.web_server_1.network_interface.0.ip_address
}

output "web_server_2_ip" {
  value = yandex_compute_instance.web_server_2.network_interface.0.ip_address
}

output "target_group_id" {
  value = yandex_lb_target_group.web_servers.id
}

output "private_ips" {
  value = [
    yandex_compute_instance.web_server_1.network_interface[0].ip_address,
    yandex_compute_instance.web_server_2.network_interface[0].ip_address
  ]
}

output "web_server_1_disk_id" {
  value = yandex_compute_instance.web_server_1.boot_disk[0].disk_id
}

output "web_server_2_disk_id" {
  value = yandex_compute_instance.web_server_2.boot_disk[0].disk_id
}
