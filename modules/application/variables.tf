variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(string)
}

variable "ssh_sg_id" {
  description = "SSH security group ID"
  type        = string
}

variable "public_http_sg_id" {
  description = "Public HTTP security group ID"
  type        = string
}

variable "private_http_sg_id" {
  description = "Private HTTP security group ID"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "launch_template_name" {
  description = "Launch template name"
  type        = string
}

variable "alb_name" {
  description = "ALB name"
  type        = string
}

variable "target_group_name" {
  description = "Target group name"
  type        = string
}

variable "asg_name" {
  description = "ASG name"
  type        = string
}
