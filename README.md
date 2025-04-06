# Jupiter Project

A comprehensive 3-tier AWS infrastructure project designed for educational purposes using Terraform.

---

## 📷 Architecture Diagram

![3-Tier Architecture](https://github.com/cloudswitch360/terraform-jupiter-project/blob/main/3_tier_png.png?raw=true)

---

## 🧭 Project Overview

The **Jupiter Project** is an educational infrastructure-as-code implementation that demonstrates how to build a robust, scalable 3-tier architecture on AWS using **Terraform**. This project is intended as a teaching tool for students learning cloud architecture, infrastructure-as-code, and AWS deployment best practices.

---

## 🏗️ 3-Tier Architecture Design

This project implements a classic 3-tier application architecture:

### 1. **Presentation Tier (Web Tier)**
- Hosted in **public subnets** across multiple availability zones
- Accessible from the internet via an **Application Load Balancer**
- Protected by **Security Groups** and **Network ACLs**

### 2. **Application Tier**
- Hosted in **private subnets** across multiple availability zones
- Not directly accessible from the internet
- Communicates with the Web and Data tiers
- Secured with **Security Groups**

### 3. **Data Tier**
- Hosted in **isolated private subnets** across multiple availability zones
- Accessible **only from the Application tier**
- Database instances with **replication for high availability**
- Fully protected by **Security Groups**

---

## ⚙️ Infrastructure Components

### 🌐 Network Infrastructure
- VPC with CIDR block `10.0.0.0/16`
- Public subnets in **two availability zones**
- Private application subnets in **two availability zones**
- Private database subnets in **two availability zones**
- **Internet Gateway** for public internet access
- **NAT Gateway** for outbound access from private subnets
- Route Tables for traffic control and subnet routing

### 🔒 Security
- **Security Groups** for each tier (Web, App, DB)
- **Network ACLs** for subnet-level protection
- **IAM Roles & Policies** for secure access control

### 💻 Compute Resources
- **Application Load Balancer** for the Web Tier
- **EC2 Instances** or **Auto Scaling Groups** for Web and Application Tiers
- *(Optional)*: **ElastiCache** for session/state management

### 🗄️ Database
- **Amazon RDS** instance with **Multi-AZ** deployment
- Custom **DB Subnet Group** for isolated DB hosting

### 📊 Monitoring and Logging
- **Amazon CloudWatch** for metrics and alarms
- **AWS CloudTrail** for logging API activities and audit trails

---

## 🎓 Educational Purpose

This project is designed specifically for **learning** and **demonstration** purposes and includes:

- Detailed comments in all Terraform files explaining each resource
- Best practices for cloud architecture and security
- A **modular architecture** to clearly show relationships between components

> ⚠️ **Note:** This is a training resource. Please **do not modify** the existing code, as it’s intentionally structured for educational clarity.

---

## 🚀 Getting Started

To deploy the Jupiter Project:

1. **Install** Terraform (version `v1.0.0+`)
2. **Configure** your AWS credentials with appropriate permissions
3. **Review** the code and comments to understand the architecture
4. Run:
   ```bash
   terraform init
   terraform plan
   terraform apply
