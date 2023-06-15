module "vpc" {
  source            = "./modules/vpc"
  vpc_cidr_block    = var.vpc_cidr_block
  subnet_cidr_block = var.subnet_cidr_block
  availability_zone = var.availability_zone
}

module "ec2_instance" {
  source            = "./modules/ec2-instance"
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  vpc_id            = module.vpc.vpc_id
  vpc_cidr_block    = var.vpc_cidr_block
  subnet_id         = module.vpc.subnet_id
  rabbitmq_username = var.rabbitmq_username
  rabbitmq_password = var.rabbitmq_password
}
