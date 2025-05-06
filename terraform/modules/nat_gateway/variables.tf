variable "network_id" {
  description = "ID of the VPC network"
  type        = string
}

variable "prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "my"
}