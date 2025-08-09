output "bastion_sg_id" {
  value = yandex_vpc_security_group.bastion_sg.id
}

output "web_sg_id" {
  value = yandex_vpc_security_group.web_sg.id
}

output "kibana_sg_id" {
  value = yandex_vpc_security_group.kibana.id
}

output "elasticsearch_sg_id" {
  value = yandex_vpc_security_group.elasticsearch.id
}

output "zabbix_sg_id" {
  value = yandex_vpc_security_group.zabbix_sg.id
}

output "nat_sg_id" {
  value = yandex_vpc_security_group.nat_sg.id
}

output "alb_sg_id" {
  description = "ID security group для ALB"
  value       = yandex_vpc_security_group.alb_sg.id
}
