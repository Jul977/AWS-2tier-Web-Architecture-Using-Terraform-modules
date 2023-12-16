output "app_lb_id" {
  value = aws_lb.application_load_balancer.id
}

output "target_group_id" {
  value = aws_lb_target_group.alb_target_group.id
}

output "target_group_arn" {
  value = aws_lb_target_group.alb_target_group.arn
}

output "alb_dns_name" {
  value = aws_lb.application_load_balancer.dns_name
}