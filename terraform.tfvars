# Variable Values

aws_region   = "us-east-1"
environment  = "dev"
project_name = "terraform-assignment"

# S3 bucket names must be globally unique - update these with unique names
state_bucket_name   = "s10arnaud-terraform-state-bucket"
dynamodb_table_name = "s1-arnaud-terraform-state-locks"
app_bucket_name     = "s10arnaud-app-bucket"

# VPC Configuration
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidr  = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"
availability_zone   = "us-east-1a"

# EC2 Configuration
key_name      = "del-labs-key"
instance_type = "t2.micro"
ami_id        = "ami-0b6c6ebed2801a5cb"
