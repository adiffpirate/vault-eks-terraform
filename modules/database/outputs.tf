output "address" {
  description = "Ingress address from ELB to access the database"
  value       = aws_db_instance.mysql.address
}

output "port" {
  description = "Exposed port that listen for connections into the database"
  value       = aws_db_instance.mysql.port
}

output "endpoint" {
  description = "Combination of address and port"
  value       = aws_db_instance.mysql.endpoint
}
