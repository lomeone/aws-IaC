variable "name" {
  type = object({
    s3                       = string
    gateway                  = string
    storage_gateway          = string
    storage_gateway_instance = string
  })

  default = {
    s3                       = "defalut"
    gateway                  = "default"
    storage_gateway          = "kafka-connect-storage-gw"
    storage_gateway_instance = "kafka-connect-storage-gw-instance"
  }
}

variable "gateway_instance_type" {
  type        = string
  default     = " m5.xlarge"
  description = "gateway instance type"
}

variable "vpc" {
  type        = string
  default     = ""
  description = "vpc id"
}

variable "instance_subnet_id" {
  type        = string
  default     = ""
  description = "subnet id"
}

variable "file_share_clients" {
  type        = list(string)
  default     = []
  description = "file share acess allow client"
}
