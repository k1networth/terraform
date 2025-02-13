cloud_id                 = "enp0l6phsq7nj2rca60a"
folder_id                = "b1g37hofm98lbmuj6k6p"
service_account_key_file = "/home/yuuarai/yandex-cloud/key.json"
zone                     = "ru-central1-b"
network_name             = "network"

subnets = {
  "subnet-a" = {
    v4_cidr_blocks = ["10.128.0.0/24"]
    zone           = "ru-central1-a"
    name           = "subnet-a"
    folder_id      = "b1g37hofm98lbmuj6k6p"
  },
  "subnet-b" = {
    v4_cidr_blocks = ["10.129.0.0/24"]
    zone           = "ru-central1-b"
    name           = "subnet-b"
    folder_id      = "b1g37hofm98lbmuj6k6p"
  },
  "subnet-d" = {
    v4_cidr_blocks = ["10.130.0.0/24"]
    zone           = "ru-central1-d"
    name           = "subnet-d"
    folder_id      = "b1g37hofm98lbmuj6k6p"
  }
}

allowed_ssh_ips = [
  { name = "Home", ip = "87.120.36.233/32" }
]

bastion_instance = {
  name        = "bastion-host"
  zone        = "ru-central1-a"
  image_id    = "fd85hkli5dp6as39ali4"
  cpu         = 2
  memory      = 2
  subnet_name = "subnet-a"
}

private_instance = {
  name        = "private-server"
  zone        = "ru-central1-b"
  image_id    = "fd85hkli5dp6as39ali4"
  cpu         = 2
  memory      = 2
  subnet_name = "subnet-b"
}

db_config = {
  name               = "test1"
  environment        = "PRODUCTION"
  zone               = "ru-central1-a"
  assign_public_ip   = true
  subnet_name        = "subnet-a"
  version            = "17"
  resource_preset_id = "s2.micro"
  disk_size          = 10
  disk_type_id       = "network-hdd"
  owner              = "test1"
  user_name          = "test1-guest"
  user_password      = "yuuaraiyuuarai"
  user_conn_limit    = 30
}
