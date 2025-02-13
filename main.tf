terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.137.0"
    }
  }

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket                      = "yuuarai"
    region                      = "ru-central1"
    key                         = "terraform/state/terraform.tfstate"
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "yandex" {
  service_account_key_file = file(var.service_account_key_file)
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

#======================== module ===============================

module "vpc" {
  source          = "./modules/vpc"
  network_name    = var.network_name
  subnets         = var.subnets
  allowed_ssh_ips = var.allowed_ssh_ips
  folder_id       = var.folder_id
}

module "db" {
  source     = "./modules/db"
  network_id = module.vpc.network_id
  subnet_id  = values(module.vpc.subnet_ids)[0]
  db_config  = var.db_config
}

module "servers" {
  source            = "./modules/servers"
  bastion_instance  = var.bastion_instance
  private_instance  = var.private_instance
  bastion_subnet_id = values(module.vpc.subnet_ids)[0]
  private_subnet_id = values(module.vpc.subnet_ids)[1]
  security_group_id = module.vpc.security_group_id
}

#======================== output ===============================

output "vpc_network_id" {
  value = module.vpc.network_id
}

output "db_cluster_id" {
  value = module.db.db_cluster_id
}

output "bastion_instance_id" {
  value = module.servers.bastion_instance_id
}

output "private_instance_id" {
  value = module.servers.private_instance_id
}
