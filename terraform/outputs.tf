output "kibana_public_ip" {
  value = module.kibana.public_ip
}

output "balancer_public_ip" {
  value = module.load_balancer.alb_ip
}

output "web_servers_private_ips" {
  value = module.web_servers.private_ips
}

output "elasticsearch_private_ip" {
  value = module.elasticsearch.private_ip
}

output "bastion_public_ip" {
  value = module.bastion.bastion_public_ip
}

output "web_sg_id" {
  value = module.security_groups.web_sg_id
}

output "web_server_1_ip" {
  value = module.web_servers.web_server_1_ip
}

output "web_server_2_ip" {
  value = module.web_servers.web_server_2_ip
}
