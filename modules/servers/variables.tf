variable "bastion_instance" {
  description = "Конфигурация для bastion-инстанса"
  type = object({
    name     = string
    zone     = string
    cpu      = number
    memory   = number
    image_id = string
  })
}

variable "private_instance" {
  description = "Конфигурация для приватного инстанса"
  type = object({
    name     = string
    zone     = string
    cpu      = number
    memory   = number
    image_id = string
  })
}

variable "bastion_subnet_id" {
  description = "ID подсети для bastion-инстанса"
  type        = string
}

variable "private_subnet_id" {
  description = "ID подсети для приватного инстанса"
  type        = string
}

variable "security_group_id" {
  description = "ID группы безопасности для инстансов"
  type        = string
}
