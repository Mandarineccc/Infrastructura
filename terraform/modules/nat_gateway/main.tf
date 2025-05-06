resource "yandex_vpc_gateway" "nat_gateway" {
  name = "${var.prefix}-nat-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "nat_route" {
  name        = "${var.prefix}-nat-route"
  network_id  = var.network_id
  description = "Route table for NAT Gateway"

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}