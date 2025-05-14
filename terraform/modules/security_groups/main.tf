resource "yandex_vpc_security_group" "bastion_sg" {
  name   = "bastion-sg"
  network_id = var.network_id

  egress {
    protocol = "tcp"
    port     = 0
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol = "tcp"
    port     = 22
    v4_cidr_blocks = [var.bastion_ip]
  }
}

resource "yandex_vpc_security_group" "web_sg" {
  name   = "web-sg"
  network_id = var.network_id

  egress {
    protocol = "tcp"
    port     = 0
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol = "tcp"
    port     = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "nat_sg" {
  name        = "nat-sg"
  network_id  = var.network_id

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "ANY"
    v4_cidr_blocks = [var.private_cidr]  # Разрешаем трафик только из приватной сети
  }
}

resource "yandex_vpc_security_group" "kibana" {
  name      = "kibana-sg"
  network_id = var.network_id
  ingress {
    protocol       = "TCP"
    port           = 5601
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "elasticsearch" {
  name      = "elasticsearch-sg"
  network_id = var.network_id
  ingress {
    protocol       = "TCP"
    port           = 9200
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "zabbix_sg" {
  name       = "zabbix-sg"
  network_id = var.network_id

  ingress {
    protocol       = "TCP"
    description    = "Zabbix frontend"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "Zabbix server port"
    port           = 10051
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
