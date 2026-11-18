# AWS Infrastructure Automation with Terraform

A hands-on Infrastructure as Code (IaC) portfolio project that provisions a small AWS environment using Terraform.

> **Portfolio transparency:** This is public repository. Update this README with your own deployment screenshots, decisions, and troubleshooting notes after you have run it. Do not describe it as production experience unless it was actually used in production.

## Architecture

The Terraform configuration creates:

- One VPC with DNS support and hostnames enabled
- One public subnet in the first available Availability Zone
- One Internet Gateway and public route table
- One EC2 instance running Amazon Linux 2023 and Nginx
- One security group with **no inbound rules**
- An EC2 IAM role and instance profile for AWS Systems Manager (SSM)
- Encrypted gp3 root storage and IMDSv2 token enforcement

Connect to the EC2 instance through **AWS Systems Manager Session Manager**. SSH (port 22) is not exposed.

## Repository structure

```text
aws-terraform-infrastructure/
├── terraform/
│   ├── versions.tf
│   ├── variables.tf
│   ├── main.tf
│   ├── outputs.tf
│   └── terraform.tfvars.example
├── .gitignore
└── README.md
```

## Prerequisites

- An AWS account
- AWS CLI configured with credentials for a user/role allowed to create the resources in this project
- Terraform CLI >= 1.5
- An AWS region with available EC2 capacity
- Permission to use Systems Manager

Never commit AWS access keys, secret keys, Terraform state, or real `.tfvars` files.

## Deploy

Run these commands from the repository root:

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars if you want to change the region or names.

aws sts get-caller-identity
terraform init
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

Review the plan carefully before applying. Terraform will create billable AWS resources.

## Connect to the instance

After deployment:

```bash
terraform output instance_id
aws ssm start-session --target "$(terraform output -raw instance_id)" --region "$(terraform output -raw aws_region)"
```

The instance installs Nginx using user data. The security group intentionally has no inbound HTTP rule, so the `website_url` output is informational and will not be reachable from the public internet with the default security group. You can verify Nginx locally from the SSM session:

```bash
curl -I http://localhost
```

## Destroy resources

When finished, destroy the environment to avoid ongoing charges:

```bash
terraform destroy
```

Confirm the destroy plan before approving it.

## Security notes

- No SSH ingress is configured.
- EC2 uses an IAM instance profile with `AmazonSSMManagedInstanceCore`.
- IMDSv2 is required.
- The root EBS volume is encrypted.
- Egress is limited to HTTPS and DNS in this demo.
- For production, consider private subnets, VPC endpoints, tighter egress controls, centralized logging, policy-as-code, remote Terraform state with locking, and least-privilege IAM policies.

## Next improvements

- Add private subnets and NAT/VPC endpoints
- Extract reusable VPC and EC2 Terraform modules
- Configure an S3 remote backend with state locking
- Add CI validation with GitHub Actions
- Add a diagram and screenshots from your own deployment
