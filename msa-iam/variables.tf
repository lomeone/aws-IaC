variable "eks" {
  type = object({
    name     = string
    arn      = string
    oidc_arn = string
    oidc_url = string
  })
}
