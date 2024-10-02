variable "name" {
  type = object({
    s3               = string
    gateway          = string
    gateway_instance = string
    iam_role         = string
    security_group   = string
  })
  default = {
    s3               = "default"
    gateway          = "default"
    gateway_instance = "default-storage-gateway-instance"
    iam_role         = "StorageGatewayBucketAccessRole"
    security_group   = "default-storage-gateway-sg"
  }
}

variable "gateway_instance_type" {
  type        = string
  default     = "m5.xlarge"
  description = "ec2 for gateway instance type"
}

variable "subnet_id" {
  type        = string
  default     = ""
  description = "subnet id"
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "vpc id"
}

variable "nfs_clients" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "nfs client list for access control"
}
