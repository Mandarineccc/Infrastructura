variable "subnet_id" {
  description = "Subnet ID to use for ALB"
  type        = string
}

variable "target_ips" {
  description = "Private IP addresses of target web servers"
  type        = list(string)
}

variable "web_sg" {
  description = "Security Group ID for the load balancer"
  type        = string
}

variable "network_id" {
  description = "VPC network ID"
  type        = string
}

variable "zone" {
  description = "Zone where ALB will be created"
  type        = string
}

variable "private_subnet_a_id" {
  description = "ID приватной подсети A"
  type        = string
}

variable "private_subnet_b_id" {
  description = "ID приватной подсети B"
  type        = string
}

variable "alb_sg_id" {
  description = "ID SG, используемой для ALB"
  type        = string
}
