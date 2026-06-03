variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "allowed_ip_range" {
  description = "Allowed IPs"
  type        = list(string)
}

variable "ssh_sg_name" {
  description = "SSH SG Name"
  type        = string
}

variable "public_http_sg_name" {
  description = "Public HTTP SG Name"
  type        = string
}

variable "private_http_sg_name" {
  description = "Private HTTP SG Name"
  type        = string
}