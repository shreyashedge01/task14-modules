variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "allowed_ip_range" {
  description = "Allowed IP ranges"
  type        = list(string)
}