output "network_id" {
  description = "ID сети VPC"
  value       = yandex_vpc_network.vpc.id
}

output "subnet_ids" {
  description = "IDs подсетей"
  value       = { for s, subnet in yandex_vpc_subnet.subnet : s => subnet.id }
}

output "security_group_id" {
  description = "ID группы безопасности"
  value       = yandex_vpc_security_group.ssh_access.id
}
