variable "name" {
  type        = string
  default     = "default"
  description = "resource name associated with the storage gateway"
}

variable "vpc" {
  type = object({
    id                               = string
    subnet_ids                       = list(string)
    gateway_instance_subnet          = string
    gateway_instance_security_groups = list(string)
    gateway_endpoint_security_groups = list(string)
  })
  description = "information abount vpc"
}

variable "instance_type" {
  type        = string
  default     = "m5.xlarge"
  description = "storage gateway instance type"
}
