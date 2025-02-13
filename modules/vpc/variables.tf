variable "network_name" {
  description = "Имя сети VPC"
  type        = string
}

variable "subnets" {
  description = "Список подсетей для VPC"
  type = map(object({
    name           = string
    v4_cidr_blocks = list(string)
    zone           = string
  }))
}

variable "allowed_ssh_ips" {
  description = "Список разрешенных IP для доступа по SSH"
  type = list(object({
    name = string
    ip   = string
  }))
}

variable "folder_id" {
  description = "ID папки Yandex Cloud"
  type        = string
}
