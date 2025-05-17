resource "aws_launch_template" "app_lt" {
  name_prefix = "tfg-app-lt"
  image_id = "ami-0c2bd79b938bf340e"
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  key_name = "tfg-demo-ami"

  tag_specifications {
    resource_type = "instance"
    tags = {
   Name = "tfg-app-instance"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.ssm_instance_profile.name
  }
}

resource "aws_autoscaling_group" "app_asg" {
  desired_capacity  = 1
  max_size  = 1
  min_size  = 1
  vpc_zone_identifier  = var.private_app_subnet_ids
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
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
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


#temporal: para debug
resource "aws_iam_role_policy" "allow_s3_logs" {
  name = "allow-logs-to-s3"
  role = aws_iam_role.ssm_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject"
        ],
        Resource = "arn:aws:s3:::tfg-marta-db-backups/ssm-logs/*"
      }
    ]
  })
}