# Account settings
variable "aws_region" {
  description = "AWS Region"
}
variable "aws_access_key" {
  description = "AWS access key"
}
variable "aws_secret_key" {
  description = "AWS secret key"
}
variable "aws_key_pair" {
  description = "AWS key-pair to use"
}
variable "aws_key_local_path" {
  description = "Local path to SSH key"
}

# VPC Config
variable "vpc_name" {
  description = "VPC name"
  default     = "ecs-test"
}
variable "vpc_cidr" {
  description = "VPC main CIDR"
  default     = "10.1.0.0/16"
}
variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b"]
}
variable "private_subnets" {
  default = ["10.1.0.0/27"]
}
variable "public_subnets" {
  default = ["10.1.10.0/27", "10.1.10.32/27"]
}
variable "tag_env" {
  description = "VPC environement tag"
  default     = "Test"
}