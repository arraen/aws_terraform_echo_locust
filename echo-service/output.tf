
output "echo_alb_dns" {
  value = aws_alb.ecs_alb.dns_name
}