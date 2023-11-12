terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "eu-west-1"
  profile = "default"
}

terraform {
  backend "s3" {
    bucket = "platform-app-state"
    key    = "ecs/ecr-state.tfstate"
    region = "eu-west-1"
  }
}