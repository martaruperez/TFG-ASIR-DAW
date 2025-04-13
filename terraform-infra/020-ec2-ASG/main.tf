resource "aws_launch_template" "app_lt" {
  name_prefix = "tfg-app-lt"
  image_id = "ami-0faab6bdbac9486fb"
  instance_type = "t3.micro"

  user_data = base64encode(<<-EOF
   #!/bin/bash
   yum update -y
   yum install -y httpd
   systemctl enable httpd
   systemctl start httpd
   echo "Hola desde ASG!" > /var/www/html/index.html
 EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
   Name = "tfg-app-instance"
    }
  }
}

resource "aws_autoscaling_group" "app_asg" {
  desired_capacity  = 1
  max_size  = 1
  min_size  = 1
  vpc_zone_identifier  = var.public_subnet_ids
  target_group_arns    = [var.target_group_arn]
  launch_template {
    id   = aws_launch_template.app_lt.id
    version = "$Latest"
  }

  tag {
    key   = "Name"
    value    = "tfg-asg-instance"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "instance_sg" {
  name   = "asg-instance-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port    = 80
    to_port  = 80
    protocol = "tcp"
    security_groups = [var.alb_sg_id]
  }

  egress {
    from_port   = 0
    to_port  = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tfg-asg-instance-sg"
  }
}
