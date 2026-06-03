
data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_launch_template" "template" {
  name = var.launch_template_name

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  user_data = base64encode(<<-EOF
#!/bin/bash

dnf update -y
dnf install -y httpd

systemctl enable httpd
systemctl start httpd

cat > /var/www/html/index.html <<HTML
<html>
<body>
<h1>works!</h1>
</body>
</html>
HTML

chmod -R 755 /var/www
chown -R apache:apache /var/www

rm -f /etc/httpd/conf.d/welcome.conf

systemctl restart httpd

EOF
  )
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true

    security_groups = [
      var.ssh_sg_id,
      var.private_http_sg_id
    ]
  }
}

resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    var.public_http_sg_id
  ]

  subnets = var.subnet_ids
}

resource "aws_lb_target_group" "tg" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_autoscaling_group" "asg" {
  name             = var.asg_name
  desired_capacity = 2
  max_size         = 2
  min_size         = 2

  vpc_zone_identifier = var.subnet_ids

  target_group_arns = [
    aws_lb_target_group.tg.arn
  ]

  health_check_type = "ELB"

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [
      load_balancers,
      target_group_arns
    ]
  }
}
