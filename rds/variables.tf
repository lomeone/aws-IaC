variable "name" {
  type = object({
    db_cluster = string
    db         = string
  })
  default = {
    db_cluster = "default-db-cluster"
    db         = "default"
  }
  description = "db clster identifier"
}

variable "admin_username" {
  type        = string
  default     = "admin"
  description = "db admin user name"
}

variable "vpc" {
  type        = string
  default     = ""
  description = "rds vpc id"
}
