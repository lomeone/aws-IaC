variable "name" {
  type = object({
    eks = string
  })
  default = {
    eks = "default"
  }
  description = "resource name"
}

variable "subnet_ids" {
  type = object({
    control_plane = list(string)
    node          = list(string)
  })
  description = "subnet ids"
}

variable "region" {
  type        = string
  default     = "ap-northeast-2"
  description = "service region"
}
