resource "aws_instance" "locust_master" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = var.ec2_instance_type
  key_name        = var.aws_key_pair
  subnet_id       = var.subnets
  security_groups = [aws_security_group.locust_master.id]

  tags = {
    Name = var.ec2_master_name
  }
}
resource "null_resource" "master_ansible_deploy" {
  provisioner "file" {
    source      = "${path.module}/files"
    destination = "/home/ec2-user/locust"
    connection {
      type        = "ssh"
      user        = var.ssh_user
      host        = aws_instance.locust_master.public_ip
      private_key = local.private_key
    }
  }
  provisioner "remote-exec" {
    inline = [<<EOT
sudo amazon-linux-extras install ansible2 -y &&
sudo yum install docker python-pip -y &&
sudo systemctl start docker &&
sudo pip install docker &&
ansible-playbook /home/ec2-user/locust/master_deploy.yml -v --extra-vars \
"test_target=http://${var.test_target} \
image=${var.locust_docker_image}"
    EOT
    ]
    connection {
      type        = "ssh"
      user        = var.ssh_user
      host        = aws_instance.locust_master.public_ip
      private_key = local.private_key
    }
  }
  triggers = {
    always_run = "${timestamp()}"
  }
}

resource "aws_instance" "locust_slave" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = var.ec2_instance_type
  key_name        = var.aws_key_pair
  subnet_id       = var.subnets
  security_groups = [aws_security_group.locust_slave.id, aws_security_group.locust_slave_access.id]
  tags = {
    Name = var.ec2_slave_name
  }
}
resource "null_resource" "slave_ansible_deploy" {
  provisioner "file" {
    source      = "${path.module}/files"
    destination = "/home/ec2-user/locust"
    connection {
      type        = "ssh"
      user        = var.ssh_user
      host        = aws_instance.locust_slave.public_ip
      private_key = local.private_key
    }
  }
  provisioner "remote-exec" {
    inline = [<<EOT
sudo amazon-linux-extras install ansible2 -y &&
sudo yum install docker python-pip -y &&
sudo systemctl start docker &&
sudo pip install docker &&
ansible-playbook /home/ec2-user/locust/slave_deploy.yml -v --extra-vars \
"master_host=${aws_instance.locust_master.private_ip} \
image=${var.locust_docker_image}"
    EOT
    ]
    connection {
      type        = "ssh"
      user        = var.ssh_user
      host        = aws_instance.locust_slave.public_ip
      private_key = local.private_key
    }
  }
  triggers = {
    always_run = "${timestamp()}"
  }
}