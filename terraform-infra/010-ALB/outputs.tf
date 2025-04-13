output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}
output "target_group_arn" {
  value = aws_lb_target_group.app_tg.arn
}

