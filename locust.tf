module "locust" {
  source             = "./locust"
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets[0]
  aws_key_pair       = var.aws_key_pair
  aws_key_local_path = var.aws_key_local_path
  test_target        = module.echo-service.echo_alb_dns
}