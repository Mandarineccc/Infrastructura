output "alb_ip" {
  description = "Public IPv4 address of the ALB"
  value       = try(
    yandex_alb_load_balancer.web_alb.listener[0].endpoint[0].address[0].external_ipv4_address[0].address,
    null
  )
}

output "target_group_id" {
  description = "ID of the target group"
  value       = yandex_alb_target_group.web_tg.id
}

output "web_sg_id" {
  description = "Security group ID for web servers"
  value       = var.web_sg
}
