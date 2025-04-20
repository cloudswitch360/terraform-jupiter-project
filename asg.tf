# search for terraform aws create a asg launch template
# terraform aws launch template
resource "aws_launch_template" "webserver_launch_template" {
  name          = "webserver-launch-template"
  image_id      = var.ec2_ami_id
  instance_type = "t2.micro"        # This can be a variable as well
  key_name      = ""                # this can be a variable as well
  description   = "launch template on asg"

  monitoring {
    enabled = true
  }

  vpc_security_group_ids = [aws_security_group.cloudswitch360_jupiter_web_sg.id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    sudo su
    yum update -y
    yum install -y httpd unzip
    cd /var/www/html
    wget https://github.com/Ahmednas211/jupiter-zip-file/raw/main/jupiter-main.zip
    unzip jupiter-main.zip
    cp -r jupiter-main/* /var/www/html
    rm -rf jupiter-main jupiter-main.zip
    systemctl start httpd
    systemctl enable httpd
  EOF
  )
}

# create auto scaling group
# terraform aws autoscaling group
resource "aws_autoscaling_group" "auto_scaling_group" {
  vpc_zone_identifier = [aws_subnet.cloudswitch360_project_private_app_subnet-az1a.id, aws_subnet.cloudswitch360_project_private_app_subnet-az1b.id]
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1
  name                = "dev-asg"
  health_check_type   = "ELB"

  launch_template {
    id      = aws_launch_template.webserver_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "asg-webserver"
    propagate_at_launch = true
  }

  lifecycle {
    ignore_changes = [target_group_arns]
  }
}

# attach auto scaling group to alb target group
# terraform aws autoscaling attachment
resource "aws_autoscaling_attachment" "asg_alb_target_group_attachment" {
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group.name
  lb_target_group_arn    = aws_lb_target_group.alb_target_group.arn
}
