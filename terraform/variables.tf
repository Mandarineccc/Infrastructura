variable "gitlab_token" {
  description = "value of gitlab token"
  type        = string
}

variable "platform_id" {
  description = "Platform for VM"
  type        = string
}

variable "sa_key_path" {
  description = "Path to the service account key file"
  type        = string
}

variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "netology-network"
}

variable "private_cidr_a" {
  description = "CIDR block for private subnet A"
  type        = string
}

variable "private_cidr_b" {
  description = "CIDR block for private subnet B"
  type        = string
}

variable "public_cidr" {
  description = "Public CIDR block"
  type        = string
}

variable "zone_1" {
  description = "Zone for private subnet 1"
  type        = string
}

variable "zone_2" {
  description = "Zone for private subnet 2"
  type        = string
}

variable "zone_3" {
  description = "Zone for public subnet"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key for VM access"
  type        = string
}
