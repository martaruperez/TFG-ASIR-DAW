#Para SSM
resource "aws_vpc_endpoint" "ssm" {
  vpc_id = aws_vpc.main.id
  service_name   = "com.amazonaws.eu-west-1.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.public_a.id,aws_subnet.public_b.id]
  security_group_ids = [aws_security_group.nat_sg.id]

  private_dns_enabled = true

  tags = {
    Name = "ssm-endpoint"
  }
}
resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id = aws_vpc.main.id
  service_name   = "com.amazonaws.eu-west-1.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.public_a.id,aws_subnet.public_b.id]
  security_group_ids = [aws_security_group.nat_sg.id]

  private_dns_enabled = true

  tags = {
    Name = "ec2messages-endpoint"
  }
}
resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id = aws_vpc.main.id
  service_name   = "com.amazonaws.eu-west-1.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.public_a.id,aws_subnet.public_b.id]
  security_group_ids = [aws_security_group.nat_sg.id]

  private_dns_enabled = true

  tags = {
    Name = "ssmmessages-endpoint"
  }
}

# Para que la DB pueda escribir en S3
resource "aws_vpc_endpoint" "s3" {
  vpc_id = aws_vpc.main.id
  service_name   = "com.amazonaws.eu-west-1.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.private_db.id
  ]

  tags = {
    Name = "tfg-s3-endpoint"
  }
}
