variable "subnet_id" {
  description = "Subnet ID where ALB will be placed"
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
