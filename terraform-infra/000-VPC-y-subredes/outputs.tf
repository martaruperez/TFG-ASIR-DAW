# para debugging, iré añadiendo según sea necesario

output "ssm_vpc_endpoints" {
  value = {
    ssm          = aws_vpc_endpoint.ssm.id
    ec2messages  = aws_vpc_endpoint.ec2messages.id
    ssmmessages  = aws_vpc_endpoint.ssmmessages.id
  }
}
output "nat_instance_id" {
  value = aws_instance.nat.id
}

output "nat_instance_public_ip" {
  value = aws_eip.nat_instance_eip.public_ip
}

output "vpc_id" {
  value = aws_vpc.main.id
}
output "public_subnet_id" {
  value = aws_subnet.public.id
}