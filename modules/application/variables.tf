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