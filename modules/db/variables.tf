variable "network_id" {
  description = "ID сети для подключения к PostgreSQL"
  type        = string
}

variable "subnet_id" {
  description = "ID подсети для подключения к PostgreSQL"
  type        = string
}

variable "db_config" {
  description = "Конфигурация для PostgreSQL"
  type = object({
    name               = string
    environment        = string
    zone               = string
    assign_public_ip   = bool
    subnet_name        = string
    version            = string
    resource_preset_id = string
    disk_size          = number
    disk_type_id       = string
    user_name          = string
    user_password      = string
    user_conn_limit    = number
  })
}
