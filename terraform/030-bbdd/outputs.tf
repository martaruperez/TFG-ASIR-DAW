output "db_private_ip" {
  value = aws_instance.mysql_db.private_ip
}
