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
  source = "./modules/vpc"
  name   = "lomeone"
  cidr   = "10.0.0.0/16"
}
