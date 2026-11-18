variable "aws_region" {
  description = "AWS region in which to create the infrastructure."
  type        = string
  default     = "eu-west-1"
}

variable "project_name" {
  description = "Short project name used in resource names and tags."
  type        = string
  default     = "devops-lab"
}

variable "environment" {
  description = "Environment name."
  type        = string
  default     = "demo"
}

variable "vpc_cidr" {
  description = "CIDR range for the VPC."
  type        = string
  default     = "10.20.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR range for the public subnet."
  type        = string
  default     = "10.20.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type. Check regional free-tier and pricing eligibility."
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "Optional Amazon Linux 2023 AMI ID. Leave empty to use the latest public SSM parameter."
  type        = string
  default     = ""
}
