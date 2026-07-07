variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "project_name" {
  description = "Project name used to tag AWS resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}
variable "public_subnet_2_cidr" {
  type = string
}

variable "private_subnet_2_cidr" {
  type = string
}