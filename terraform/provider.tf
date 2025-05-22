provider "yandex" {
  # твоя конфигурация
}

provider "null" {}


provider "yandex" {
  service_account_key_file = var.sa_key_path
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
}
