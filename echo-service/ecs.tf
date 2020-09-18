resource "aws_ecs_cluster" "test" {
  name = var.ecs_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "echo_service" {
  family                = "echo-service"
  container_definitions = file("${path.module}/files/task.json")
}

resource "aws_ecs_service" "echo_service" {
  name            = "echo-service"
  cluster         = aws_ecs_cluster.test.id
  desired_count   = 1
  task_definition = aws_ecs_task_definition.echo_service.arn
  iam_role        = aws_iam_role.ecs-service-role.arn
  load_balancer {
    target_group_arn = aws_alb_target_group.echo.id
    container_name   = "echo-service"
    container_port   = "8080"
  }
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
}