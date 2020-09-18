
output "locust_master_ip" {
  value = module.locust.locust_master_ip
}
output "locust_slave_ip" {
  value = module.locust.locust_slave_ip
}
output "echo_service_elb_url" {
  value = module.echo-service.echo_alb_dns
}
output "locust_master_url" {
  value = module.locust.locust_master_url
}

