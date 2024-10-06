resource "aws_instance" "storage_gateway" {
  ami           = "ami-01fd5b5ea8a90f2d0"
  instance_type = var.storage_gateway.gateway_instance
  subnet_id     = var.vpc.gateway_instance_subnet

  associate_public_ip_address = true
  vpc_security_group_ids      = var.vpc.gateway_instance_security_groups

  root_block_device {
    volume_size = 80
    volume_type = "gp3"
    iops        = 3000
    throughput  = 125
  }

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = 150
    volume_type = "gp3"
    iops        = 3000
    throughput  = 125
  }

  tags = {
    Name = "${var.name.gateway_instance}"
  }
}

resource "tls_private_key" "storage_gateway" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "storage_gateway" {
  key_name   = "my-key-pair"
  public_key = tls_private_key.storage_gateway.public_key_openssh
}

output "private_key_pem" {
  value     = tls_private_key.storage_gateway.private_key_pem
  sensitive = true
}

output "public_key_openssh" {
  value = tls_private_key.storage_gateway.public_key_openssh
}
