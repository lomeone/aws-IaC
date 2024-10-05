resource "aws_instance" "storage_gateway" {
  ami           = "ami-0f54e3fa9a943bb68"
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
