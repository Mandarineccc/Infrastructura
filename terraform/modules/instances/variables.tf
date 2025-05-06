variable "instance_name" {
  description = "Name of the instance"
  type        = string
}

variable "platform_id" {
  description = "Platform ID for the instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the instance is located"
  type        = string
}

variable "public_ip" {
  description = "Whether to assign a public IP"
  type        = bool
}

variable "security_group" {
  description = "Security group ID"
  type        = string
}

variable "image_id" {
  description = "ID of the image for boot disk"
  type        = string
}
