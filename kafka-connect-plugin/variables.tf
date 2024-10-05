variable "name" {
  type = object({
    s3               = string
    gateway          = string
    gateway_instance = string
    iam_role         = string
  })
  default = {
    s3               = "default"
    gateway          = "default"
    gateway_instance = "default-storage-gateway-instance"
    iam_role         = "StorageGatewayBucketAccessRole"
  }
  description = "resource name"
}

variable "vpc" {
  type = object({
    id                               = string
    subnet_ids                       = list(string)
    gateway_instance_subnet          = string
    gateway_instance_security_groups = list(string)
    gateway_endpoint_security_groups = list(string)
  })
  description = "vpc info"
}

variable "storage_gateway" {
  type = object({
    gateway_instance = string
    nfs_clients      = list(string)
  })
  default = {
    gateway_instance = "m5.xlarge"
    nfs_clients      = ["0.0.0.0/0"]
  }
}
