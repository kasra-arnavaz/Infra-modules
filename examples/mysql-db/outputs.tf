output "address" {
  value       = module.mysql_example.address
  description = "Connect to the database at this endpoint"
}

output "port" {
  value       = module.mysql_example.port
  description = "The port the database is listening on"
}

output "arn" {
  value       = module.mysql_example.arn
  description = "The ARN of the database"
}
