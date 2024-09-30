resource "aws_instance" "gateway_instance" {
  ami           = "ami-0f54e3fa9a943bb68" // aws-storage-gateway-FILE_S3-1.26.1
  instance_type = var.gateway_instance_type
  subnet_id     = var.instance_subnet_id

  associate_public_ip_address = true

  tags = {
    Name = "${var.name.storage_gateway_instance}"
  }
}

resource "aws_security_group" "s3_gateway_instance" {
  vpc_id = var.vpc

}
