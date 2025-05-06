variable "platform_id" {
  description = "Platform ID for the instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for Elasticsearch instance"
  type        = string
}

variable "zone" {
  description = "The zone where Elasticsearch will be deployed"
  type        = string
}

variable "image_id" {
  description = "ID of the image for boot disk"
  type        = string
}

variable "sg_id" {
  description = "Security group ID for Elasticsearch"
  type        = string
}