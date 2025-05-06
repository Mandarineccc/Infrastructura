output "kibana_public_ip" {
  value = module.kibana.public_ip
}

output "balancer_public_ip" {
  value = module.load_balancer.public_ip
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
  value = yandex_vpc_security_group.web.id
}