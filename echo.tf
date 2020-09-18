module "echo-service" {
  source       = "./echo-service"
  vpc_id       = module.vpc.vpc_id
  subnets      = module.vpc.public_subnets
  aws_key_pair = var.aws_key_pair
}