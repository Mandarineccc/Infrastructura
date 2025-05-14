output "web_sg_id" {
  value = yandex_vpc_security_group.web_sg.id
}

output "zabbix_sg_id" {
  value = yandex_vpc_security_group.zabbix_sg.id
}

output "kibana_sg_id" {
  value = yandex_vpc_security_group.kibana_sg.id
}

output "elasticsearch_sg_id" {
  value = yandex_vpc_security_group.elasticsearch_sg.id
}

output "bastion_sg_id" {
  value = yandex_vpc_security_group.bastion_sg.id
}
