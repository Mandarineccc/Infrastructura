terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "16.8.1"
    }
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.142.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.0.0"
    }
  }
}

provider "gitlab" {
  token = var.gitlab_token
}

provider "yandex" {
  service_account_key_file = var.sa_key_path
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
}
