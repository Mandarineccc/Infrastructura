variable "network_id" {
  description = "ID of the VPC network"
  type        = string
}

variable "bastion_ip" {
  description = "IP for Bastion SSH access"
  type        = string
}

variable "private_cidr_a" {
  description = "CIDR for private subnet A"
  type        = string
}

variable "private_cidr_b" {
  description = "CIDR for private subnet B"
  type        = string
}

