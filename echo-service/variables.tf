variable "aws_key_pair" {
  description = "AWS key-pair to use"
}
# VPC config
variable "vpc_id" {
  description = "VPC ID"
}
variable "subnets" {
  description = "Subnet to place service"
}

# ECS Config
variable "ecs_name" {
  description = "VPC name"
  default     = "ecs-test"
}
variable "ecs_asg_name" {
  description = "Auto-scaling group name for ECS"
  default     = "echo_asg"
}
## AWS ECS optimized ami
data "aws_ami" "amazon_linux_ecs" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}
data "template_file" "ecs-cluster" {
  template = "${file("${path.module}/files/ecs-cluster.tpl")}"

  vars = {
    ecs_name = var.ecs_name
  }
}