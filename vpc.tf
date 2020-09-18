module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.44.0"

  name = var.vpc_name
  cidr = var.vpc_cidr
  azs             = var.availability_zones
  public_subnets  = var.public_subnets
  enable_nat_gateway = false

  tags = {
    Env  = var.tag_env
    Name = var.vpc_name
  }
}