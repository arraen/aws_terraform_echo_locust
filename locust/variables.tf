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

# EC2 Resources
variable "ssh_user" {
  description = "SSH user for EC2 access"
  default     = "ec2-user"
}
variable "aws_key_local_path" {
  description = "Local path to SSH key"
}
variable "ec2_instance_type" {
  default = "t2.micro"
}
variable "ec2_master_name" {
  description = "Name tag for master instance"
  default     = "locust-master"
}
variable "ec2_slave_name" {
  description = "Name tag for slave instance"
  default     = "locust-slave"
}
## Latest Amazon Linux 2 AMI
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

# Locust
variable "locust_docker_image" {
  description = "locust docker image"
  default     = "locustio/locust:1.1.1"
}
variable "test_target" {
  description = "Test target url"
}

# Ansible
locals {
  private_key = "${file("${var.aws_key_local_path}")}"
}