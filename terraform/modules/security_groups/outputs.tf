output "bastion_sg_id" {
  value = yandex_vpc_security_group.bastion_sg.id
}

output "web_sg" {
  value = yandex_vpc_security_group.web_sg.id
}

output "kibana_sg_id" {
  value = yandex_vpc_security_group.kibana.id
}

output "elasticsearch_sg_id" {
  value = yandex_vpc_security_group.elasticsearch.id
}