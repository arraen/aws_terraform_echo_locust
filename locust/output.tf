output "locust_master_ip" {
  value = aws_instance.locust_master.public_ip
}
output "locust_slave_ip" {
  value = aws_instance.locust_slave.public_ip
}

output "locust_master_url" {
  value = "http://${aws_instance.locust_master.public_ip}:8080"
}