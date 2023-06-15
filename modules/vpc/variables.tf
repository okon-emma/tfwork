variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  type        = string
}

variable "subnet_cidr_block" {
  description = "Subnet CIDR block"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone for the VPC"
  type        = string
}
