# Jupiter Project

A comprehensive 3-tier AWS infrastructure project designed for educational purposes using Terraform.

## Project Overview

The Jupiter Project is an educational infrastructure-as-code implementation that demonstrates how to build a robust, scalable 3-tier architecture on AWS using Terraform. This project is intended as a teaching tool for students learning cloud architecture, infrastructure-as-code, and AWS deployment best practices.

## 3-Tier Architecture Design

The project implements a classic 3-tier application architecture:

1. **Presentation Tier (Web Tier)**
   - Hosted in public subnets across multiple availability zones
   - Accessible from the internet via an Application Load Balancer
   - Protected by security groups and network ACLs

2. **Application Tier**
   - Hosted in private subnets across multiple availability zones
   - Not directly accessible from the internet
   - Communicates with the web tier and database tier
   - Protected by security groups

3. **Data Tier**
   - Hosted in isolated private subnets across multiple availability zones
   - Only accessible from the application tier
   - Database instances with replication for high availability
   - Protected by security groups

## Infrastructure Components

The following components will be implemented:

### Network Infrastructure
- VPC with CIDR block 10.0.0.0/16
- Public subnets in two availability zones
- Private application subnets in two availability zones
- Private database subnets in two availability zones
- Internet Gateway for public internet access
- NAT Gateway for private subnet outbound access
- Route tables for traffic management

### Security
- Security Groups for each tier
- Network ACLs for subnet-level security
- IAM roles and policies for secure resource access

### Compute Resources
- Application Load Balancer for the web tier
- EC2 instances or Auto Scaling Groups for the web and application tiers
- Optional: Elasticache for session management

### Database
- RDS instance with Multi-AZ deployment
- Subnet group for database placement

### Monitoring and Logging
- CloudWatch for monitoring and alerts
- CloudTrail for API logging

## Educational Purpose

This project is designed specifically for educational purposes and includes:
- Detailed comments in all Terraform files explaining each resource
- Best practices for infrastructure design and security
- Modular architecture to demonstrate component relationships

**Note**: This is a training resource. Do not modify existing code as it's structured specifically for teaching purposes.

## Getting Started

1. Ensure you have Terraform installed (v1.0.0+)
2. Configure AWS credentials with appropriate permissions
3. Review the code and comments to understand the architecture
4. Run `terraform init` to initialize the project
5. Run `terraform plan` to see the execution plan
6. Run `terraform apply` to deploy the infrastructure
7. When finished, run `terraform destroy` to remove all resources


## Future Components

The following components will be added to complete the architecture:
- EC2 Auto Scaling Groups
- Application Load Balancer
- RDS Database
- Security Groups
- CloudWatch Monitoring
- S3 for static assets
- CloudFront for content delivery

## Contributing

This project is for educational purposes. Please do not modify the existing code as it's intended to train students.