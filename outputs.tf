# Root Module Outputs

# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = module.vpc.private_subnet_id
}

# EC2 Outputs
output "bastion_public_ip" {
  description = "Public IP of the bastion host - use this to SSH"
  value       = module.ec2.bastion_public_ip
}

output "private_instance_private_ip" {
  description = "Private IP of the private instance - SSH from bastion"
  value       = module.ec2.private_instance_private_ip
}

# S3 Outputs
output "state_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  value       = module.backend.s3_bucket_id
}

output "app_bucket_name" {
  description = "Name of the application S3 bucket"
  value       = module.s3.bucket_id
}

# Connection Instructions
output "ssh_instructions" {
  description = "Instructions to connect to instances"
  value       = <<-EOT
    
    === SSH Connection Instructions ===
    
    1. SSH to Bastion Host:
       ssh -i del-labs-key.pem ec2-user@${module.ec2.bastion_public_ip}
    
    2. From Bastion, SSH to Private Instance:
       ssh -i del-labs-key.pem ec2-user@${module.ec2.private_instance_private_ip}
    
    3. Test NAT Gateway (on private instance):
       sudo yum update -y
    
  EOT
}
