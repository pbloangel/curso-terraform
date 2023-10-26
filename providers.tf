terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.19.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
  required_version = ">=1.5.7"
}



provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = var.tags
  }
}