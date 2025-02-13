terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.137.0"
    }
  }
}

resource "yandex_vpc_network" "vpc" {
  name      = var.network_name
  folder_id = var.folder_id
}

resource "yandex_vpc_subnet" "subnet" {
  for_each       = var.subnets
  name           = each.value.name
  v4_cidr_blocks = each.value.v4_cidr_blocks
  zone           = each.value.zone
  network_id     = yandex_vpc_network.vpc.id
  folder_id      = lookup(each.value, "folder_id", var.folder_id)
}

resource "yandex_vpc_security_group" "ssh_access" {
  name       = "ssh-access"
  network_id = yandex_vpc_network.vpc.id
  folder_id  = var.folder_id

  dynamic "ingress" {
    for_each = var.allowed_ssh_ips
    content {
      protocol       = "TCP"
      description    = ingress.value.name
      v4_cidr_blocks = [ingress.value.ip]
      port           = 22
    }
  }

  egress {
    protocol       = "ANY"
    description    = "To internet"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
