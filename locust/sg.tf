resource "aws_security_group" "locust_slave_access" {
  description = "Access from locust slave"
  name        = "locust_slave_access"
  tags = {
    "Name" = "Access from locust slave"
  }
  vpc_id = var.vpc_id
}

resource "aws_security_group" "locust_master" {
  description = "Locus master access"
  name        = "locust_master"
  tags = {
    "Name" = "Locus master access"
  }
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "locust_master_egress" {
  cidr_blocks = [
    "0.0.0.0/0",
  ]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.locust_master.id
  to_port           = 0
  type              = "egress"
}
resource "aws_security_group_rule" "locust_master_http" {
  security_group_id = aws_security_group.locust_master.id
  type              = "ingress"
  description       = "Locust HTTP web interface"
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "locust_master_port" {
  security_group_id        = aws_security_group.locust_master.id
  type                     = "ingress"
  description              = "Locust master access"
  from_port                = 5557
  protocol                 = "tcp"
  to_port                  = 5557
  source_security_group_id = aws_security_group.locust_slave_access.id
}
resource "aws_security_group_rule" "locust_master_ssh" {
  security_group_id = aws_security_group.locust_master.id
  type              = "ingress"
  description       = "SSH access"
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "locust_slave" {
  description = "Locus slave access"
  name        = "locust_slave"
  tags = {
    "Name" = "Locus slave access"
  }
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "locust_slave_egress" {
  cidr_blocks = [
    "0.0.0.0/0",
  ]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.locust_slave.id
  to_port           = 0
  type              = "egress"
}
resource "aws_security_group_rule" "locust_slave_ssh" {
  security_group_id = aws_security_group.locust_slave.id
  type              = "ingress"
  description       = "SSH access"
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
}