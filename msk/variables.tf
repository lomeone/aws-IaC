variable "name" {
  type = object({
    msk = string
    security_group = string
  })
  default = {
    msk = "default-msk"
    security_group = "msk-security-group"
  }
  description = "msk resource name"
}

variable "vpc" {
  type = string
  default = ""
  description = "msk vpc id"
}

variable "kafka_version" {
  type = string
  default = "3.5.1"
  description = "kafka version"
}

variable "broker_count" {
  type = number
  default = 3
  description = "broker count"
}

variable "broker_size" {
  type = string
  default = "kafka.m7.large"
  description = "kafka broker instance type"
}

variable "subnet_ids" {
  type = list(string)
  default = []
  description = "kafka broker subnet"
}

variable "volume_size" {
  type = number
  default = 1000
  description = "kafka cluster volume size"
}

variable "security_gropus" {
  type = list(string)
  default = []
  description = "kafka security groups"
}
