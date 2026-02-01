# EC2 Module Variables

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet"
  type        = string
}

variable "private_subnet_id" {
  description = "ID of the private subnet"
  type        = string
}

variable "key_name" {
  description = "Name of the existing SSH key pair in AWS"
  type        = string
  default     = "del-labs-key"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0b6c6ebed2801a5cb"
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "terraform-assignment"
}
