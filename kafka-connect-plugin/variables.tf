variable "name" {
  type = object({
    s3       = string
    gateway  = string
    iam_role = string
  })
  default = {
    s3       = "default"
    gateway  = "default"
    iam_role = "StorageGatewayBucketAccessRole"
  }
}

variable "nfs_clients" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "nfs client list for access control"
}
