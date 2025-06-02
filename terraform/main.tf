module "vpc" {
  source       = "./modules/vpc"
  network_name = "my-network"
  providers = {
    yandex = yandex
  }
}

module "nat_gateway" {
  source     = "./modules/nat_gateway"
  network_id = module.vpc.network_id
  prefix     = "prod"
  providers = {
    yandex = yandex
  }
}

module "subnets" {
  source         = "./modules/subnets"
  network_id     = module.vpc.network_id
  route_table_id = module.nat_gateway.route_table_id

  zone_1 = "ru-central1-a"
  zone_2 = "ru-central1-b"
  zone_3 = "ru-central1-a"

  private_cidr_a = "10.0.1.0/24"
  private_cidr_b = "10.0.2.0/24"
  public_cidr    = "10.0.3.0/24"

  providers = {
    yandex = yandex
  }
}

module "bastion" {
  source              = "./modules/bastion"
  platform_id         = var.platform_id
  subnet_id           = module.subnets.public_subnet_id
  zone                = "ru-central1-a"
  image_id            = "fd8oqjs5ram7b6higj34"
  sg_id               = yandex_vpc_security_group.temp_bastion_sg.id
  ssh_public_key_path = var.ssh_public_key_path
  providers = {
    yandex = yandex
  }
}

resource "yandex_vpc_security_group" "temp_bastion_sg" {
  name       = "temp-bastion-sg"
  network_id = module.vpc.network_id

  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

module "security_groups" {
  source         = "./modules/security_groups"
  network_id     = module.vpc.network_id
  bastion_ip     = module.bastion.bastion_public_ip
  private_cidr_a = module.subnets.private_cidr_a
  private_cidr_b = module.subnets.private_cidr_b
  providers = {
    yandex = yandex
  }
}

resource "yandex_vpc_security_group_rule" "bastion_final_rule" {
  security_group_binding = module.security_groups.bastion_sg_id
  direction              = "ingress"
  port                   = 22
  protocol               = "tcp"
  v4_cidr_blocks         = ["${module.bastion.bastion_public_ip}/32"]
}

resource "null_resource" "cleanup_temp_sg" {
  depends_on = [module.security_groups]

  provisioner "local-exec" {
    command = "yc vpc security-group delete ${yandex_vpc_security_group.temp_bastion_sg.id}"
  }
}

module "kibana" {
  source              = "./modules/kibana"
  platform_id         = var.platform_id
  subnet_id           = module.subnets.public_subnet_id
  zone                = "ru-central1-a"
  image_id            = "fd8oqjs5ram7b6higj34"
  sg_id               = module.security_groups.kibana_sg_id
  ssh_public_key_path = var.ssh_public_key_path
  providers = {
    yandex = yandex
  }
}

module "elasticsearch" {
  source              = "./modules/elasticsearch"
  platform_id         = var.platform_id
  subnet_id           = module.subnets.private_subnet_a_id
  zone                = var.zone_1
  image_id            = "fd8oqjs5ram7b6higj34"
  sg_id               = module.security_groups.elasticsearch_sg_id
  ssh_public_key_path = var.ssh_public_key_path
  providers = {
    yandex = yandex
  }
}

module "web_servers" {
  source      = "./modules/web_servers"
  platform_id = var.platform_id
  subnet_ids = {
    zone_1 = module.subnets.private_subnet_a_id,
    zone_2 = module.subnets.private_subnet_b_id
  }
  image_id            = "fd8oqjs5ram7b6higj34"
  sg_id               = module.security_groups.web_sg_id
  zone_1              = var.zone_1
  zone_2              = var.zone_2
  ssh_public_key_path = var.ssh_public_key_path
  providers = {
    yandex = yandex
  }
}

module "load_balancer" {
  source = "./modules/load_balancer"
  target_ips = [
    module.web_servers.web_server_1_ip,
    module.web_servers.web_server_2_ip
  ]
  subnet_id           = module.subnets.public_subnet_id
  network_id          = module.vpc.network_id
  zone                = "ru-central1-a"
  web_sg              = module.security_groups.web_sg_id
  private_subnet_a_id = module.subnets.private_subnet_a_id
  private_subnet_b_id = module.subnets.private_subnet_b_id
  providers = {
    yandex = yandex
  }
}

module "zabbix_server" {
  source              = "./modules/zabbix_server"
  platform_id         = var.platform_id
  zone                = "ru-central1-a"
  image_id            = "fd8oqjs5ram7b6higj34"
  subnet_id           = module.subnets.public_subnet_id
  sg_id               = module.security_groups.zabbix_sg_id
  ssh_public_key_path = var.ssh_public_key_path
  providers = {
    yandex = yandex
  }
}

module "snapshot_bastion" {
  source        = "./modules/snapshot"
  schedule_name = "bastion-snapshot"
  disk_ids      = [module.bastion.disk_id]
  instance_name = "bastion"
}

module "snapshot_elasticsearch" {
  source        = "./modules/snapshot"
  schedule_name = "elasticsearch-snapshot"
  disk_ids      = [module.elasticsearch.disk_id]
  instance_name = "elasticsearch"
}

module "snapshot_kibana" {
  source        = "./modules/snapshot"
  schedule_name = "kibana-snapshot"
  disk_ids      = [module.kibana.disk_id]
  instance_name = "kibana"
}

module "snapshot_web1" {
  source        = "./modules/snapshot"
  schedule_name = "web1-snapshot"
  disk_ids      = [module.web_servers.web_server_1_disk_id]
  instance_name = "web1"
}

module "snapshot_web2" {
  source        = "./modules/snapshot"
  schedule_name = "web2-snapshot"
  disk_ids      = [module.web_servers.web_server_2_disk_id]
  instance_name = "web2"
}

module "snapshot_zabbix" {
  source        = "./modules/snapshot"
  schedule_name = "zabbix-snapshot"
  disk_ids      = [module.zabbix_server.disk_id]
  instance_name = "zabbix"
}
