variable "platform_id" {
  type = string
}

variable "zone" {
  type = string
}

variable "image_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "sg_id" {
  type = string
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key for access"
  type        = string
}
