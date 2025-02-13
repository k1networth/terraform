terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.137.0"
    }
  }
}

resource "yandex_compute_instance" "bastion" {
  name        = var.bastion_instance.name
  zone        = var.bastion_instance.zone
  platform_id = "standard-v2"
  resources {
    cores  = var.bastion_instance.cpu
    memory = var.bastion_instance.memory
  }
  boot_disk {
    initialize_params {
      image_id = var.bastion_instance.image_id
    }
  }
  network_interface {
    subnet_id          = var.bastion_subnet_id
    security_group_ids = [var.security_group_id]
    nat                = true
  }
  metadata = {
    user-data = <<-EOT
			#cloud-config
			users:
				- name: ubuntu
					sudo: ["ALL=(ALL) NOPASSWD:ALL"]
					shell: /bin/bash
					ssh-authorized-keys:
						- ${file("~/.ssh/id_rsa.pub")}
		EOT
  }
}

resource "yandex_compute_instance" "private" {
  name        = var.private_instance.name
  zone        = var.private_instance.zone
  platform_id = "standard-v2"
  resources {
    cores  = var.private_instance.cpu
    memory = var.private_instance.memory
  }
  boot_disk {
    initialize_params {
      image_id = var.private_instance.image_id
    }
  }
  network_interface {
    subnet_id          = var.private_subnet_id
    security_group_ids = [var.security_group_id]
  }
  metadata = {
    user-data = <<-EOT
			#cloud-config
			users:
				- name: ubuntu
					sudo: ["ALL=(ALL) NOPASSWD:ALL"]
					shell: /bin/bash
					ssh-authorized-keys:
						- ${file("~/.ssh/id_rsa.pub")}
		EOT
  }
}
