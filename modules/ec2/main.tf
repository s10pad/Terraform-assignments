# EC2 Module - Instances and Security Groups

# Security Group for Public EC2 (Bastion Host)
resource "aws_security_group" "public" {
  name        = "${var.project_name}-public-sg"
  description = "Security group for bastion host - allows SSH from anywhere"
  vpc_id      = var.vpc_id

  # SSH access from anywhere (can be restricted later)
  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-public-sg"
    Environment = var.environment
  }
}

# Security Group for Private EC2
resource "aws_security_group" "private" {
  name        = "${var.project_name}-private-sg"
  description = "Security group for private instance - allows SSH only from bastion"
  vpc_id      = var.vpc_id

  # SSH access only from the public security group (bastion)
  ingress {
    description     = "SSH from bastion host only"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public.id]
  }

  # Allow all outbound traffic (for NAT Gateway access)
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-private-sg"
    Environment = var.environment
  }
}

# Public EC2 Instance (Bastion Host)
resource "aws_instance" "public" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.public.id]
  associate_public_ip_address = true

  tags = {
    Name        = "${var.project_name}-bastion"
    Environment = var.environment
    Role        = "Bastion Host"
  }
}

# Private EC2 Instance
resource "aws_instance" "private" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.private.id]
  associate_public_ip_address = false

  tags = {
    Name        = "${var.project_name}-private"
    Environment = var.environment
    Role        = "Private Instance"
  }
}
