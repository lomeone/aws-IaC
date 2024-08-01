data "aws_availability_zones" "available" {
    state = "available"
}

locals {
    az = data.aws_availability_zones.available.names
    subnet = {
        "public" = [for i in [10, 20] : cidrsubnet(var.cidr, 8, i)]
        "private" = [for i in [30, 40] : cidrsubnet(var.cidr, 8, 1)]
    }
}