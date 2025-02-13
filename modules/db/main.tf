terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.137.0"
    }
  }
}

resource "yandex_mdb_postgresql_cluster" "db" {
  name        = var.db_config.name
  network_id  = var.network_id
  environment = var.db_config.environment

  host {
    zone             = var.db_config.zone
    assign_public_ip = var.db_config.assign_public_ip
    subnet_id        = var.subnet_id
  }

  config {
    version = var.db_config.version
    resources {
      resource_preset_id = var.db_config.resource_preset_id
      disk_size          = var.db_config.disk_size
      disk_type_id       = var.db_config.disk_type_id
    }
  }
}

resource "yandex_mdb_postgresql_user" "test1_guest" {
  cluster_id = yandex_mdb_postgresql_cluster.db.id
  name       = var.db_config.user_name
  password   = var.db_config.user_password
  conn_limit = var.db_config.user_conn_limit

  depends_on = [yandex_mdb_postgresql_cluster.db]
}

resource "yandex_mdb_postgresql_database" "test1" {
  cluster_id = yandex_mdb_postgresql_cluster.db.id
  name       = var.db_config.name
  owner      = var.db_config.user_name

  depends_on = [yandex_mdb_postgresql_user.test1_guest]
}
