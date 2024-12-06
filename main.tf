terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.72.0"
    }
  }

  required_version = ">= 1.9.5"
}

provider "aws" {
  region = "ap-northeast-2"

  default_tags {
    tags = {
      MakeBy = "terraform"
    }
  }
}

module "vpc" {
  source = "./modules/vpc"
  name = {
    vpc                           = "lomeone-vpc"
    public_subnet                 = "public"
    eks_control_plane_subnet      = "eks-private"
    private_subnet                = "private"
    db_private_subnet             = "db-private"
    eks_control_plane_route_table = "eks-control-plane-rtb"
    public_route_table            = "public-rtb"
    private_route_table           = "private-rtb"
    db_route_table                = "db-rtb"
    internet_gateway              = "igw"
    public_nat_gateway            = "nat-public-gw"
    eks                           = "lomeone-eks"
  }
  cidr                    = "10.0.0.0/16"
  availability_zone_count = 3
  subnet_cidr = {
    public            = ["10.0.0.0/26", "10.0.0.64/26", "10.0.0.128/26"]
    eks_control_plane = ["10.0.0.192/28", "10.0.0.208/28", "10.0.0.224/28"]
    db_private        = ["10.0.8.0/21", "10.0.16.0/21", "10.0.24.0/21"]
    private           = ["10.0.64.0/18", "10.0.128.0/18", "10.0.192.0/18"]
  }
}

module "security_group" {
  source = "./modules/security-group"

  vpc = {
    id   = module.vpc.vpc_id
    name = module.vpc.vpc_name
  }
}

module "eks" {
  source = "./modules/eks"

  name = {
    eks = "lomeone-eks"
  }

  subnet_ids = {
    control_plane = module.vpc.subnet_ids.eks_control_plane
    node          = module.vpc.subnet_ids.private_subnets
  }
}

module "endpoint" {
  source = "./modules/vpc-endpoint"

  vpc = {
    id   = module.vpc.vpc_id
    name = module.vpc.vpc_name
  }

  subnet_ids = {
    public  = module.vpc.subnet_ids.public_subnets
    private = module.vpc.subnet_ids.private_subnets
  }

  route_table_ids = concat(module.vpc.route_table_id.public, module.vpc.route_table_id.private)
}
