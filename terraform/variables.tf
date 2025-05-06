variable "platform_id" {
  description = "Платформа для всех виртуальных машин"
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

variable "private_cidr" {
  description = "Private CIDR block"
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
