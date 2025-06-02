resource "yandex_compute_snapshot_schedule" "vm_snapshot_schedule" {
  name        = var.schedule_name
  description = "Daily snapshot for ${var.instance_name}"

  schedule_policy {
    expression = "0 3 * * *" # Каждый день в 03:00
  }

  snapshot_count = 7 # Хранить 7 дней

  disk_ids = var.disk_ids

  retention_period = "168h" # 7 дней

  labels = {
    project = "diploma"
  }
}
