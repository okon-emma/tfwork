variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "rabbitmq_username" {
  description = "RabbitMQ username"
  type        = string
}

variable "rabbitmq_password" {
  description = "RabbitMQ password"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone for EBS volume"
  type        = string
}

variable "key_name" {
  description = "Key pair name for EC2 instance"
  type        = string
  default     = "rmqi"
}
