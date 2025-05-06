resource "yandex_vpc_security_group" "bastion_base" {
  name        = "bastion-base-sg"
  network_id  = var.network_id
  description = "Base group for bastion with temporary rules"

  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"] # Временное правило, будет обновлено
  }
}

output "bastion_sg_id" {
  value = yandex_vpc_security_group.bastion_base.id
}
