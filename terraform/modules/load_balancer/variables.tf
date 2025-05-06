variable "subnet_id" {
  description = "Subnet ID for the load balancer"
  type        = string
}

variable "target_ips" {
  description = "IP addresses of target web servers"
  type        = list(string)
}

variable "web_sg" {
  description = "Security group ID for load balancer"
  type        = string
}

variable "network_id" {
  type = string
}

variable "zone_1" {
  type = string
}
