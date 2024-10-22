variable "name" {
  type        = string
  default     = "default-msk"
  description = "msk name"
}

variable "vpc" {
  type = object({
    subnet_ids      = list(string)
    security_groups = list(string)
  })
  description = "vpc info"
}

variable "kafka" {
  type = object({
    version         = string
    broker_count    = number
    broker_instance = string
    volume_size     = number
  })
  default = {
    version         = "3.5.1"
    broker_count    = 3
    broker_instance = "kafka.m7g.large"
    volume_size     = 1000
  }
  description = "kafka info"
}
