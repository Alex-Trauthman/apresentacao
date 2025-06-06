terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    key    = "terraform.tfstate"
    region = "us-east-1"
    bucket = "estados-ambientes"
  }
}

provider "aws" {
  region = "us-east-1"
}