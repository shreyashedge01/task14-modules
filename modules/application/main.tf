data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_launch_template" "template" {
  name = "cmtr-ouv17nh6-template"

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  user_data = base64encode(<<-EOF
#!/bin/bash

yum update -y
yum install -y httpd

systemctl start httpd
systemctl enable httpd

COMPUTE_MACHINE_UUID=$$(cat /sys/devices/virtual/dmi/id/product_uuid | tr '[:upper:]' '[:lower:]')

TOKEN=$$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

COMPUTE_INSTANCE_ID=$$(curl -H "X-aws-ec2-metadata-token: $${TOKEN}" http://169.254.169.254/latest/meta-data/instance-id)

echo "This message was generated on instance $${COMPUTE_INSTANCE_ID} with UUID $${COMPUTE_MACHINE_UUID}" > /var/www/html/index.html

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
  name               = "cmtr-ouv17nh6-lb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    var.public_http_sg_id
  ]

  subnets = var.subnet_ids
}

resource "aws_lb_target_group" "tg" {
  name     = "cmtr-ouv17nh6-tg"
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
  name             = "cmtr-ouv17nh6-asg"
  desired_capacity = 2
  max_size         = 2
  min_size         = 2

  vpc_zone_identifier = var.subnet_ids

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

resource "aws_autoscaling_attachment" "asg_attach" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn    = aws_lb_target_group.tg.arn
}


