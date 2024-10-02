resource "aws_instance" "storage_gateway" {
  ami           = "ami-0f54e3fa9a943bb68"
  instance_type = var.gateway_instance_type
  subnet_id     = var.subnet_id

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.s3_stroage_gateway.id]

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
