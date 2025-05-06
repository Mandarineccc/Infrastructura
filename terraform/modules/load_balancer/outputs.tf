output "lb_public_ip" {
  value = yandex_alb_load_balancer.web_alb.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
}

output "target_group_id" {
  value = yandex_alb_target_group.web_tg.id
}
