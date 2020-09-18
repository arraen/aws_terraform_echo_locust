# Sample AWS enviroment configruation done using terraform/terragrunt + ansible
1. Setup minimal AWS configuration.
2. Create echo service in AWS ECS, create EC2 instance with locust tests.

## This env provide examples for such areas:
* AWS VPC
* AWS IAM
* AWS Security groups
* AWS ECS powered echo-service
* Locust test

## Deploy process
* Enter configuration to enf.tfvars
* terraform init
* terraform plan -var-file="env.tfvars" -out=deploy.plan
* terraform apply deploy.plan

## To minimize unnecessary efforts:
* Skip CloudWatch log  setup
* Assumed that an existing key will be used
* EC2 instances SSH open to the world
* Local state used
* No AMI creation
* No DNS names creation
