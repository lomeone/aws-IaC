resource "aws_instance" "storage_gateway" {
  ami           = "ami-0f54e3fa9a943bb68"
  instance_type = var.gateway_instance_type
  subnet_id     = var.subnet_id

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.s3_stroage_gateway.id]

  ebs_block_device {
    device_name = ""
    volume_size = 150
    volume_type = "gp3"
    iops        = 3000
  }

  tags = {
    Name = "${var.name.gateway_instance}"
  }
}
