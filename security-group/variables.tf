variable "vpc" {
  type = object({
    id   = string,
    name = string
  })
  default = {
    id   = ""
    name = ""
  }
  description = "vpc information"
}
