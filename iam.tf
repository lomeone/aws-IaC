module "application" {
  source = "./modules/application-iam"

  eks = {
    name     = module.eks.eks_info.name
    arn      = module.eks.eks_info.arn
    oidc_arn = module.eks.eks_info.oidc_arn
    oidc_url = module.eks.eks_info.oidc_url
  }
}
