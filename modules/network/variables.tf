variable "vpc_name" {
  description = "VPC Name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "subnet_public_a_name" {
  description = "Subnet A name"
  type        = string
}

variable "subnet_public_b_name" {
  description = "Subnet B name"
  type        = string
}

variable "subnet_public_c_name" {
  description = "Subnet C name"
  type        = string
}

variable "subnet_public_a_cidr" {
  description = "Subnet A CIDR"
  type        = string
}

variable "subnet_public_b_cidr" {
  description = "Subnet B CIDR"
  type        = string
}

variable "subnet_public_c_cidr" {
  description = "Subnet C CIDR"
  type        = string
}

variable "az_a" {
  description = "AZ A"
  type        = string
}

variable "az_b" {
  description = "AZ B"
  type        = string
}

variable "az_c" {
  description = "AZ C"
  type        = string
}

variable "igw_name" {
  description = "IGW Name"
  type        = string
}

variable "rt_name" {
  description = "Route table name"
  type        = string
}