output "sql_instance_connection_name" {
  value = google_sql_database_instance.sql_database_instance.connection_name
}

output "database_connection_string" {
  value     = "postgresql://${var.database_user}:${var.database_password}@${google_sql_database_instance.sql_database_instance.public_ip_address}/${var.database_name}"
  sensitive = true
}