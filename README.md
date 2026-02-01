# AWS Bastion Host Infrastructure with Terraform

Welcome! This project sets up a secure AWS infrastructure using Terraform. Perfect for learning how cloud networking and security work together.

## What Are We Building?

```
    YOU (Local Machine)
         |
         | SSH (port 22)
         v
  +-------------+
  |   BASTION   |  <-- Public EC2 (has public IP)
  |    HOST     |
  +-------------+
         |
         | SSH (port 22) - only from bastion!
         v
  +-------------+
  |   PRIVATE   |  <-- Private EC2 (no public IP)
  |   SERVER    |      Can reach internet via NAT Gateway
  +-------------+
```

**Why this setup?** The private server is protected from direct internet access. The only way in is through the bastion host - like a security checkpoint!

---

## Project Structure

```
Terraform-assignments/
|
|-- main.tf              # Wires all modules together
|-- variables.tf         # Input variables
|-- outputs.tf           # Output values (IPs, IDs, etc.)
|-- providers.tf         # AWS provider config
|-- terraform.tfvars     # Your custom values (edit this!)
|
|-- modules/
    |
    |-- backend/         # S3 bucket + DynamoDB for state storage
    |   |-- main.tf
    |   |-- variables.tf
    |   |-- outputs.tf
    |
    |-- vpc/             # Networking: VPC, subnets, gateways, routes
    |   |-- main.tf
    |   |-- variables.tf
    |   |-- outputs.tf
    |
    |-- s3/              # Independent S3 bucket
    |   |-- main.tf
    |   |-- variables.tf
    |   |-- outputs.tf
    |
    |-- ec2/             # EC2 instances + security groups
        |-- main.tf
        |-- variables.tf
        |-- outputs.tf
```

---

## Prerequisites

Before you start, make sure you have:

- [ ] **Terraform installed** - [Download here](https://developer.hashicorp.com/terraform/downloads)
- [ ] **AWS CLI installed** - [Download here](https://aws.amazon.com/cli/)
- [ ] **AWS credentials configured** - Run `aws configure`
- [ ] **An SSH key pair** in AWS (we use `del-labs-key`) #Create/Use your own

---

## Step-by-Step Guide

### Step 1: Clone the Repository

```bash
git clone https://github.com/s10pad/Terraform-assignments.git
cd Terraform-assignments
```

### Step 2: Update Your Variables

Open `terraform.tfvars` and update these values:

```hcl
# IMPORTANT: S3 bucket names must be globally unique!
state_bucket_name = "your-unique-name-terraform-state"
app_bucket_name   = "your-unique-name-app-bucket"

# Update if your key pair has a different name
key_name = "del-labs-key"
```

### Step 3: Initialize Terraform

This downloads the AWS provider and sets up the modules:

```bash
terraform init
```

You should see: `Terraform has been successfully initialized!`

### Step 4: Preview the Changes

See what Terraform will create (without actually creating it):

```bash
terraform plan
```

Review the output - you'll see ~15 resources to be created.

### Step 5: Apply the Configuration

Ready? Let's build it!

```bash
terraform apply
```

Type `yes` when prompted. Grab a coffee - this takes 2-3 minutes.

### Step 6: Get Your Connection Info

After apply completes, you'll see outputs like:

```
bastion_public_ip = "54.123.45.67"
private_instance_private_ip = "10.0.2.100"
```

---

## Testing Your Infrastructure

### Connect to Bastion Host

```bash
ssh -i your-key.pem ec2-user@<bastion_public_ip>
```

### From Bastion, Connect to Private Instance

First, copy your key to the bastion (or use SSH agent forwarding):

```bash
# On bastion host:
ssh -i your-key.pem ec2-user@<private_instance_private_ip>
```

### Test NAT Gateway (on Private Instance)

```bash
sudo yum update -y
```

If this works, your NAT Gateway is configured correctly! The private instance can reach the internet for updates but can't be reached directly from the internet.

---

## Clean Up (Don't Forget!)

When you're done, destroy everything to avoid AWS charges:

```bash
terraform destroy
```

Type `yes` to confirm.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "bucket already exists" | S3 names are global - make yours unique! |
| "key pair not found" | Create the key pair in AWS console first |
| Can't SSH to bastion | Check security group allows your IP |
| Can't SSH to private | Make sure you're connecting FROM the bastion |

---

## What Did We Learn?

- **VPC** - Your own private network in AWS
- **Subnets** - Public (internet-facing) vs Private (isolated)
- **Internet Gateway** - Connects public subnet to internet
- **NAT Gateway** - Lets private subnet reach internet (outbound only)
- **Security Groups** - Firewalls controlling traffic
- **Bastion Host** - Secure entry point to private resources

---

## Resources

- [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/)
- [Bastion Host Best Practices](https://aws.amazon.com/solutions/implementations/linux-bastion/)

---

Happy Terraforming! 
