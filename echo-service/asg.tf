
resource "aws_launch_template" "ecs_asg_template" {
  name          = "${var.ecs_asg_name}_ecs_cluster"
  key_name      = var.aws_key_pair
  image_id      = data.aws_ami.amazon_linux_ecs.id
  instance_type = "t2.micro"
  user_data     = base64encode(data.template_file.ecs-cluster.rendered)
  #network_interfaces {
  #associate_public_ip_address = true
  #security_groups = [aws_security_group.ecs_test_web.id]
  #}
  iam_instance_profile {
    name = aws_iam_instance_profile.ecs-instance-profile.id
  }
}

resource "aws_autoscaling_group" "ecs_asg" {
  name                      = var.ecs_asg_name
  health_check_type         = "EC2"
  max_size                  = 1
  min_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  launch_template {
    id      = aws_launch_template.ecs_asg_template.id
    version = "$Latest"
  }
  lifecycle {
    create_before_destroy = true
  }
  vpc_zone_identifier = var.subnets
  tags = [
    {
      key                 = "Cluster"
      value               = var.ecs_name
      propagate_at_launch = true
    },
  ]
}