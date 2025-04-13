resource "aws_instance" "nat" {
  ami                    = "ami-0137cee1a6fb4f763" 
  instance_type          = "t3.micro"   
  subnet_id              = aws_subnet.public.id
  associate_public_ip_address = true
  source_dest_check      = false 

  tags = {
    Name = "tfg-nat-instance"
  }

  vpc_security_group_ids = [aws_security_group.nat_sg.id]
}

resource "aws_eip" "nat_instance_eip" {
  instance = aws_instance.nat.id
  domain   = "vpc"
}

resource "aws_security_group" "nat_sg" {
  name   = "nat-instance-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["172.16.0.0/16"] # Permite tráfico desde tu VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nat-instance-sg"
  }
}