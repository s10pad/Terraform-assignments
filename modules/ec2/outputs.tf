# EC2 Module Outputs

output "bastion_public_ip" {
  description = "Public IP of the bastion host"
  value       = aws_instance.public.public_ip
}

output "bastion_instance_id" {
  description = "Instance ID of the bastion host"
  value       = aws_instance.public.id
}

output "private_instance_id" {
  description = "Instance ID of the private instance"
  value       = aws_instance.private.id
}

output "private_instance_private_ip" {
  description = "Private IP of the private instance"
  value       = aws_instance.private.private_ip
}

output "public_security_group_id" {
  description = "ID of the public security group"
  value       = aws_security_group.public.id
}

output "private_security_group_id" {
  description = "ID of the private security group"
  value       = aws_security_group.private.id
}
