variable "vpc" {
  type = object({
    id   = string
    name = string
  })
}

variable "subnet_ids" {
  type = object({
    public  = list(string)
    private = list(string)
  })
}

variable "route_table_ids" {
  type = list(string)
}
