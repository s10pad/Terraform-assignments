# AWS Provider Configuration

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Uncomment after backend resources are created
  # backend "s3" {
  #   bucket         = "your-terraform-state-bucket-name"
  #   key            = "terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-state-locks"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = var.aws_region
}
