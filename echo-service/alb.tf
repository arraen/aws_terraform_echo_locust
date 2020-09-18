resource "aws_alb" "ecs_alb" {
  name            = "ecs-alb"
  subnets         = var.subnets
  security_groups = [aws_security_group.ecs_test_web.id]
}

resource "aws_alb_listener" "echo_listener" {
  load_balancer_arn = aws_alb.ecs_alb.id
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.echo.id
    type             = "forward"
  }
}

resource "aws_alb_target_group" "echo" {
  name     = "echo"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}