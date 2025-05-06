variable "platform_id" {
  description = "Platform ID for VMs"
  type        = string
}

variable "subnet_ids" {
  description = "Map of subnet IDs for each zone"
  type        = map(string)
}

variable "image_id" {
  description = "Image ID for VMs"
  type        = string
}

variable "sg_id" {
  description = "Security group ID"
  type        = string
}

variable "zone_1" {
  description = "First availability zone"
  type        = string
}

variable "zone_2" {
  description = "Second availability zone"
  type        = string
}
