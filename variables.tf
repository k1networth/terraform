variable "cloud_id" {
  description = "Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Folder ID"
  type        = string
}

variable "service_account_key_file" {
  description = "Path to the service account key file"
  type        = string
}

variable "zone" {
  description = "Zone for resources"
  type        = string
}

variable "network_name" {
  description = "Network name"
  type        = string
}

variable "subnets" {
  description = "Subnets configuration"
  type = map(object({
    name           = string
    v4_cidr_blocks = list(string)
    zone           = string
    folder_id      = string
  }))
}

variable "allowed_ssh_ips" {
  description = "List of allowed SSH IPs"
  type = list(object({
    name = string
    ip   = string
  }))
}

variable "bastion_instance" {
  description = "Bastion instance configuration"
  type = object({
    name        = string
    zone        = string
    subnet_name = string
    cpu         = number
    memory      = number
    image_id    = string
  })
}

variable "private_instance" {
  description = "Private instance configuration"
  type = object({
    name        = string
    zone        = string
    subnet_name = string
    cpu         = number
    memory      = number
    image_id    = string
  })
}

variable "db_config" {
  description = "Database configuration"
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
