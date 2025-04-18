resource "aws_security_group" "alb_sg" {
  name = "alb-sg"
  description = "Allow HTTP inbound"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port  = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}

resource "aws_lb" "app_alb" {
  name = "tfg-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb_sg.id]
  subnets = var.public_subnet_ids

  tags = {
    Name = "tfg-alb"
  }
}

resource "aws_lb_target_group" "app_tg" {
  name  = "tfg-tg"
  port  = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path  = "/"
    protocol = "HTTP"
    interval = 30
    timeout  = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "tfg-tg"
  }
}
