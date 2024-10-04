terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.9.2"
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
  source = "./vpc"
  name = {
    vpc                           = "hansu-vpc"
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
  }
  cidr                    = "10.0.0.0/16"
  availability_zone_count = 3
  subnet_cidr = {
    public            = ["10.0.0.0/27", "10.0.0.32/27", "10.0.0.64/27"]
    eks_control_plane = ["10.0.0.192/28", "10.0.0.208/28", "10.0.0.224/28"]
    private           = ["10.0.16.0/20", "10.0.32.0/20", "10.0.48.0/20"]
    db_private        = ["10.0.244.0/22", "10.0.248.0/22", "10.0.252.0/22"]
  }
}

module "rds" {
  source = "./rds"

  name = {
    db_cluster = "hansu-aurora-rds"
    db         = "hansu-db"
  }

  vpc = module.vpc.vpc_id
}

module "msk" {
  source = "./msk"

  name = {
    msk            = "hansu-msk"
    security_group = "hansu-msk-sg"
  }

  vpc        = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids.private_subnets
}

module "kafka-connect-plugin" {
  source = "./kafka-connect-plugin"

  name = {
    s3               = "kafka-connect-plugin-storage"
    gateway          = "kafka-connect-plugin-storage-gateway"
    gateway_instance = "kafka-connect-plugin-storage-gateway"
    iam_role         = "StorageGatewayBucketAccessRole"
    security_group   = "kafka-plugin-storage-gateway-sg"
  }

  subnet_id = module.vpc.subnet_ids.public_subnets[0]
  vpc_id    = module.vpc.vpc_id
}
