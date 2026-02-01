# Root Module - Main Configuration

# Backend Module - S3 and DynamoDB for state management
module "backend" {
  source = "./modules/backend"

  bucket_name         = var.state_bucket_name
  dynamodb_table_name = var.dynamodb_table_name
  environment         = var.environment
}

# VPC Module - Networking
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone   = var.availability_zone
  environment         = var.environment
  project_name        = var.project_name
}

# S3 Module - Independent bucket
module "s3" {
  source = "./modules/s3"

  bucket_name       = var.app_bucket_name
  environment       = var.environment
  enable_versioning = true
}

# EC2 Module - Bastion and Private instances
module "ec2" {
  source = "./modules/ec2"

  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  key_name          = var.key_name
  instance_type     = var.instance_type
  ami_id            = var.ami_id
  environment       = var.environment
  project_name      = var.project_name
}
