resource "aws_security_group" "db_sg" {
  name = "tfg-db-sg"
  description = "permitir acceso a MySQL a las instacias del ASG"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = [var.asg_instance_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tfg-db-sg"
  }
}

resource "aws_instance" "mysql_db" {
  ami    = "ami-02de7012a2c26ced6"
  instance_type  = "t2.micro"
  subnet_id     = var.private_db_subnet_id
  vpc_security_group_ids      = [aws_security_group.db_sg.id]
  associate_public_ip_address = false

  tags = {
    Name = "tfg-db-instance"
  }
}
