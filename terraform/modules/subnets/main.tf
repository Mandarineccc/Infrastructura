resource "yandex_vpc_subnet" "private_a" {
  name           = "private-subnet-a"
  zone           = var.zone_1
  network_id     = var.network_id
  v4_cidr_blocks = [var.private_cidr_a]
  route_table_id = var.route_table_id
}

resource "yandex_vpc_subnet" "private_b" {
  name           = "private-subnet-b"
  zone           = var.zone_2
  network_id     = var.network_id
  v4_cidr_blocks = [var.private_cidr_b]
  route_table_id = var.route_table_id
}

resource "yandex_vpc_subnet" "public" {
  name           = "public-subnet"
  zone           = var.zone_3
  network_id     = var.network_id
  v4_cidr_blocks = [var.public_cidr]
}
