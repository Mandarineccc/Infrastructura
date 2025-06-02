variable "schedule_name" {
  description = "Название расписания снапшотов"
  type        = string
}

variable "disk_ids" {
  description = "Список ID дисков, которые нужно снэпшотить"
  type        = list(string)
}

variable "instance_name" {
  description = "Имя ВМ для описания снапшота"
  type        = string
}
