output "lb_public_ip" {
  value = yandex_alb_load_balancer.web_alb.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
}

output "target_group_id" {
  value = yandex_alb_target_group.web_tg.id
}

output "web_sg_id" {
  value = var.web_sg
}

output "alb_ip" {
  description = "Public IPv4 address of the ALB"
  value       = yandex_alb_load_balancer.web_alb.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
}
