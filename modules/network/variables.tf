variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "subnet_public_a_name" {
  description = "Public subnet A name"
  type        = string
}

variable "subnet_public_b_name" {
  description = "Public subnet B name"
  type        = string
}

variable "subnet_public_c_name" {
  description = "Public subnet C name"
  type        = string
}

variable "subnet_public_a_cidr" {
  description = "Public subnet A CIDR"
  type        = string
}

variable "subnet_public_b_cidr" {
  description = "Public subnet B CIDR"
  type        = string
}

variable "subnet_public_c_cidr" {
  description = "Public subnet C CIDR"
  type        = string
}

variable "az_a" {
  description = "Availability Zone A"
  type        = string
}

variable "az_b" {
  description = "Availability Zone B"
  type        = string
}

variable "az_c" {
  description = "Availability Zone C"
  type        = string
}

variable "igw_name" {
  description = "Internet gateway name"
  type        = string
}

variable "rt_name" {
  description = "Route table name"
  type        = string
}

