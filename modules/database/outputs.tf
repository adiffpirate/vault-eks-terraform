output "database" {
  value = {
    address = aws_db_instance.mysql.address
    port = aws_db_instance.mysql.port
    endpoint = aws_db_instance.mysql.endpoint
  }
}
