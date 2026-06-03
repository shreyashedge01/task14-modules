variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(string)
}

variable "ssh_sg_id" {
  description = "SSH SG ID"
  type        = string
}

variable "public_http_sg_id" {
  description = "Public HTTP SG ID"
  type        = string
}

variable "private_http_sg_id" {
  description = "Private HTTP SG ID"
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
  description = "Application load balancer name"
  type        = string
}

variable "target_group_name" {
  description = "Target group name"
  type        = string
}

variable "asg_name" {
  description = "Auto scaling group name"
  type        = string
}