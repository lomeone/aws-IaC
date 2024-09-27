variable "name" {
  type = object({
    gateway = string
  })

  default = {
    gateway = "default"
  }
}
