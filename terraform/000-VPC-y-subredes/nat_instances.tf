# NAT Instance en eu-west-1a
resource "aws_instance" "nat_1a" {
  ami   = "ami-0137cee1a6fb4f763"
  instance_type    = "t3.micro"
  subnet_id = aws_subnet.public_a.id
  associate_public_ip_address = true
  source_dest_check = false

  tags = {
    Name = "tfg-nat-instance-1a"
  }

  vpc_security_group_ids = [aws_security_group.nat_sg.id]
}

# NAT Instance en eu-west-1b
resource "aws_instance" "nat_1b" {
  ami = "ami-0137cee1a6fb4f763"
  instance_type    = "t3.micro"
  subnet_id = aws_subnet.public_b.id
  associate_public_ip_address = true
  source_dest_check = false

  tags = {
    Name = "tfg-nat-instance-1b"
  }

  vpc_security_group_ids = [aws_security_group.nat_sg.id]
}

# IPs elásticas
resource "aws_eip" "nat_1a_eip" {
  instance = aws_instance.nat_1a.id
  domain = "vpc"
}

resource "aws_eip" "nat_1b_eip" {
  instance = aws_instance.nat_1b.id
  domain = "vpc"
}

# Security Group
resource "aws_security_group" "nat_sg" {
  name = "nat-instance-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["172.16.0.0/16"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nat-instance-sg"
  }
}
