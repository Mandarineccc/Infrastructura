module "vpc" {
  source       = "./modules/vpc"
  network_name = "my-network"
}

module "nat_gateway" {
  source     = "./modules/nat_gateway"
  network_id = module.vpc.network_id
  prefix     = "prod"
}

module "subnets" {
  source       = "./modules/subnets"
  network_id   = module.vpc.network_id
  route_table_id = module.nat_gateway.route_table_id  # Передаем ID таблицы маршрутизации
  zone_1       = "ru-central1-a"
  zone_2       = "ru-central1-b"
  zone_3       = "ru-central1-c"
  private_cidr = "10.0.1.0/24"
  public_cidr  = "10.0.2.0/24"
}

module "bastion" {
  source      = "./modules/bastion"
  platform_id = var.platform_id
  subnet_id   = module.subnets.public_subnet_id  # Исправлено имя output
  zone        = var.zone_3
  image_id    = "fd8tvc3529h2cpjvpkr5"
  sg_id       = yandex_vpc_security_group.temp_bastion_sg.id
}

resource "yandex_vpc_security_group" "temp_bastion_sg" {
  name        = "temp-bastion-sg"
  network_id  = module.vpc.network_id
  
  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"] # Временное правило
  }
}

module "security_groups" {
  source     = "./modules/security_groups"
  network_id = module.vpc.network_id
  bastion_ip = module.bastion.bastion_public_ip
  private_cidr = module.subnets.private_cidr
}

resource "yandex_vpc_security_group_rule" "bastion_final_rule" {
  security_group_binding = module.security_groups.bastion_sg_id
  direction             = "ingress"
  port                  = 22
  protocol              = "tcp"
  v4_cidr_blocks = ["${module.bastion.bastion_public_ip}/32"]
}

# Удаляем временную security group (опционально)
resource "null_resource" "cleanup_temp_sg" {
  depends_on = [module.security_groups]
  
  provisioner "local-exec" {
    command = "yc vpc security-group delete ${yandex_vpc_security_group.temp_bastion_sg.id}"
  }
}

module "kibana" {
  source      = "./modules/kibana"
  platform_id = var.platform_id
  subnet_id   = module.subnets.public_subnet_id  # Исправлено имя output
  zone        = var.zone_3
  image_id    = "fd8tvc3529h2cpjvpkr5"
  sg_id       = module.security_groups.kibana_sg_id  # Добавлена security group
}

module "elasticsearch" {
  source      = "./modules/elasticsearch"
  platform_id = var.platform_id
  subnet_id   = module.subnets.private_subnet_a_id  # Исправлено имя output
  zone        = var.zone_1
  image_id    = "fd8tvc3529h2cpjvpkr5"
  sg_id       = module.security_groups.elasticsearch_sg_id  # Добавлена security group
}

module "web_servers" {
  source      = "./modules/web_servers"
  platform_id = var.platform_id
  subnet_ids  = {
    zone_1 = module.subnets.private_subnet_a_id,
    zone_2 = module.subnets.private_subnet_b_id
  }
  image_id    = "fd8tvc3529h2cpjvpkr5"
  sg_id       = module.security_groups.web_sg_id  # Добавлена security group
  zone_1      = var.zone_1
  zone_2      = var.zone_2
}


module "load_balancer" {
  source      = "./modules/load_balancer"
  subnet_id   = module.subnets.public_subnet_id
  target_ips  = [
    module.web_servers.web_server_1_ip,
    module.web_servers.web_server_2_ip
  ]
  web_sg = module.security_groups.web_sg
}