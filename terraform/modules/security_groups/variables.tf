variable "network_id" {
  description = "ID of the VPC network"
  type        = string
}

variable "bastion_ip" {
  description = "IP for Bastion SSH access"
  type        = string
}

variable "private_cidr" {
  description = "CIDR приватной сети"
  type        = string
}
