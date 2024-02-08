terraform {
  backend "s3" {
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.35.0"
    }
  }

  required_version = "~> 1.6"
}

provider "aws" {
  default_tags {
    tags = local.tags
  }
  region = var.aws_region
}
