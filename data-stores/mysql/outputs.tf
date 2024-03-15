output "address" {
  value       = aws_db_instance.example.address
  description = "Connect to the database at this endpoint"
}

output "port" {
  value       = aws_db_instance.example.port
  description = "The port the database is listening on"
}

output "name" {
  value       = aws_db_instance.example.db_name
  description = "The name of the database"
}

output "table" {
  value       = var.table
  description = "The name of the table in the database"
}

output "username" {
  value       = var.db_username
  description = "The username of the database"
  sensitive   = true
}

output "password" {
  value       = var.db_password
  description = "The password of the database"
  sensitive   = true
}

