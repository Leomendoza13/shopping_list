#modules/storage/outputs.tf

output "sql_instance_connection_name" {
  value = google_sql_database_instance.sql_database_instance.connection_name
}