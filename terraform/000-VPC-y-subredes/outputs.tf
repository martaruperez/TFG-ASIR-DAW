# para debugging, iré añadiendo según sea necesario

output "ssm_vpc_endpoints" {
  value = {
    ssm    = aws_vpc_endpoint.ssm.id
    ec2messages  = aws_vpc_endpoint.ec2messages.id
    ssmmessages  = aws_vpc_endpoint.ssmmessages.id
  }
}

output "nat_instance_ids" {
  value = [
    aws_instance.nat_1a.id,
    aws_instance.nat_1b.id
  ]
}

output "nat_instance_public_ips" {
  value = [
    aws_eip.nat_1a_eip.public_ip,
    aws_eip.nat_1b_eip.public_ip
  ]
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]
}

output "private_app_subnet_ids" {
  value = [
    aws_subnet.private_app_a.id,
    aws_subnet.private_app_b.id
  ]
}

output "private_db_subnet_id" {
  value = aws_subnet.private_db.id
}

output "s3_vpc_endpoint_id" {
  value = aws_vpc_endpoint.s3.id
}