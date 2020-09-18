resource "aws_security_group" "ecs_test_web" {
  description = "Test HTTPS access SG"
  name        = "ecs-test-web"
  tags = {
    "Name" = "Test HTTPS access SG"
  }
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ecs_test_web_egress" {
  cidr_blocks = [
    "0.0.0.0/0",
  ]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.ecs_test_web.id
  to_port           = 0
  type              = "egress"
}

# Access from compute
resource "aws_security_group_rule" "ecs_test_web_http" {
  security_group_id = aws_security_group.ecs_test_web.id
  type              = "ingress"
  description       = "Simple HTTP access"
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}
