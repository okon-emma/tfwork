resource "aws_key_pair" "rabbitmq_key" {
  key_name   = var.key_name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}

resource "aws_instance" "rabbitmq" {
  ami                    = "ami-0ff8a91507f77f867"
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.rabbitmq.id]
  key_name               = var.key_name

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y rabbitmq-server",
      "sudo rabbitmqctl add_user ${var.rabbitmq_username} ${var.rabbitmq_password}",
      "sudo rabbitmqctl set_user_tags ${var.rabbitmq_username} administrator",
      "sudo rabbitmqctl set_permissions -p / ${var.rabbitmq_username} '.*' '.*' '.*'"
    ]
  }

  tags = {
    Name = "Rabbitmq EC2 instance"
  }
}

resource "aws_security_group" "rabbitmq" {
  name        = "rabbitmq-sg"
  description = "Security group for EC2 instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5672
    to_port         = 5672
    protocol        = "tcp"
    security_groups = [var.vpc_cidr_block]
  }

  ingress {
    from_port       = 15672
    to_port         = 15672
    protocol        = "tcp"
    security_groups = [var.vpc_cidr_block]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [var.vpc_cidr_block]
  }
}

resource "aws_ebs_volume" "rabbitmq_data" {
  availability_zone = var.availability_zone
  size              = 40
  tags = {
    Name = "Rabbitmq volume"
  }
}

resource "aws_volume_attachment" "rabbitmq_data_attachment" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.rabbitmq_data.id
  instance_id = aws_instance.rabbitmq.id
}
