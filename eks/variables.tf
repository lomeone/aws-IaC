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
  type    = list(string)
  default = []
}
