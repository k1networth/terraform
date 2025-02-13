output "bastion_instance_id" {
  description = "ID bastion-инстанса"
  value       = yandex_compute_instance.bastion.id
}

output "private_instance_id" {
  description = "ID приватного инстанса"
  value       = yandex_compute_instance.private.id
}
