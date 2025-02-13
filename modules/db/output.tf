output "db_cluster_id" {
  description = "ID кластера PostgreSQL"
  value       = yandex_mdb_postgresql_cluster.db.id
}

output "db_user_name" {
  description = "Имя пользователя PostgreSQL"
  value       = yandex_mdb_postgresql_user.test1_guest.name
}

output "db_database_name" {
  description = "Имя базы данных PostgreSQL"
  value       = yandex_mdb_postgresql_database.test1.name
}
