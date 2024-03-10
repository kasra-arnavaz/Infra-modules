output "address" {
  value       = aws_db_instance.books.address
  description = "Connect to the database at this endpoint"
}

output "port" {
  value       = aws_db_instance.books.port
  description = "The port the database is listening on"
}

output "arn" {
  value       = aws_db_instance.books.arn
  description = "The ARN of the database"
}
