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

variable "node_group" {
  type = object({
    node_instance_type = list(string)
    min_size           = number
    max_size           = number
    desired_size       = number
  })
  default = {
    node_instance_type = ["t4g.medium"]
    min_size           = 1
    max_size           = 3
    desired_size       = 1
  }
}
