terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.4.0"
    }
  }
}

provider "aws" {
  # Configuration options
  # you can give access key and secret here, but security problem because we pushing code to github so we are doing aws configure on server
  region = "us-east-1"
}

