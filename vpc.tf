# This file contains the VPC configuration for the CloudSwitch360 project.
resource "aws_vpc" "cloudswitch360_project_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "cloudswitch360_project_vpc"
  }
}

# This resource creates an Internet Gateway and attaches it to the VPC.
resource "aws_internet_gateway" "cloudswitch360_project_igw" {
  vpc_id = aws_vpc.cloudswitch360_project_vpc.id

  tags = {
    Name = "cloudswitch360_project_igw"
  }
}

# This resource creates a public subnet AZ 1a in the VPC.
# Ensure you name the subnet to public_subnet-az1a to match the naming convention.
resource "aws_subnet" "cloudswitch360_project_public_subnet-az1a" {
  vpc_id                  = aws_vpc.cloudswitch360_project_vpc.id
  cidr_block              = var.public_subnet_az1a_cidr
  availability_zone       = "us-east-2a" # Change this to your desired availability zone
  map_public_ip_on_launch = true

  depends_on = [aws_vpc.cloudswitch360_project_vpc,
  aws_internet_gateway.cloudswitch360_project_igw]

  tags = {
    Name = "cloudswitch360_project_public_subnet-az1a"
  }
}

# Create a public subnet in AZ 1b in the VPC.
# Ensure you name the subnet to public_subnet-az1b to match the naming convention.
resource "aws_subnet" "cloudswitch360_project_public_subnet-az1b" {
  vpc_id                  = aws_vpc.cloudswitch360_project_vpc.id
  cidr_block              = var.public_subnet_az1b_cidr
  availability_zone       = "us-east-2b" # Change this to your desired availability zone
  map_public_ip_on_launch = true

  depends_on = [aws_vpc.cloudswitch360_project_vpc,
    aws_internet_gateway.cloudswitch360_project_igw
  ]

  tags = {
    Name = "cloudswitch360_project_public_subnet-az1b"
  }
}

# Create a Private app subnet in AZ 1a in the VPC.
# Ensure you name the subnet to private_app_subnet-az1a to match the naming convention.
resource "aws_subnet" "cloudswitch360_project_private_app_subnet-az1a" {
  vpc_id                  = aws_vpc.cloudswitch360_project_vpc.id
  cidr_block              = var.private_app_az1a_cidr
  availability_zone       = "us-east-2a" # Change this to your desired availability zone
  map_public_ip_on_launch = false        # Set to false for private subnets ( Note: Private subnets should not have public IPs assigned to instances by default.)

  depends_on = [aws_vpc.cloudswitch360_project_vpc,
    aws_internet_gateway.cloudswitch360_project_igw
  ]

  tags = {
    Name = "cloudswitch360_project_private_app_subnet-az1a"
  }
}

# Create a Private app subnet in AZ 1b in the VPC.
# Ensure you name the subnet to private_app_subnet-az1b to match the naming convention.
resource "aws_subnet" "cloudswitch360_project_private_app_subnet-az1b" {
  vpc_id                  = aws_vpc.cloudswitch360_project_vpc.id
  cidr_block              = var.private_app_az1b_cidr
  availability_zone       = "us-east-2b" # Change this to your desired availability zone
  map_public_ip_on_launch = false        # Set to false for private subnets ( Note: Private subnets should not have public IPs assigned to instances by default.)

  depends_on = [aws_vpc.cloudswitch360_project_vpc,
    aws_internet_gateway.cloudswitch360_project_igw
  ]

  tags = {
    Name = "cloudswitch360_project_private_app_subnet-az1b"
  }
}

# Create a Private DB subnet in AZ 1a in the VPC.
# Ensure you name the subnet to private_db_subnet-az1a to match the naming convention.
resource "aws_subnet" "cloudswitch360_project_private_db_subnet-az1a" {
  vpc_id                  = aws_vpc.cloudswitch360_project_vpc.id
  cidr_block              = var.private_db_az1a_cidr
  availability_zone       = "us-east-2a" # Change this to your desired availability zone
  map_public_ip_on_launch = false        # Set to false for private subnets ( Note: Private subnets should not have public IPs assigned to instances by default.)

  depends_on = [aws_vpc.cloudswitch360_project_vpc,
    aws_internet_gateway.cloudswitch360_project_igw
  ]

  tags = {
    Name = "cloudswitch360_project_private_db_subnet-az1a"
  }
}

# Create a Private DB subnet in AZ 1b in the VPC.
# Ensure you name the subnet to private_db_subnet-az1b to match the naming convention.
resource "aws_subnet" "cloudswitch360_project_private_db_subnet-az1b" {
  vpc_id                  = aws_vpc.cloudswitch360_project_vpc.id
  cidr_block              = var.private_db_az1b_cidr
  availability_zone       = "us-east-2b" # Change this to your desired availability zone
  map_public_ip_on_launch = false        # Set to false for private subnets ( Note: Private subnets should not have public IPs assigned to instances by default.)

  depends_on = [aws_vpc.cloudswitch360_project_vpc,
    aws_internet_gateway.cloudswitch360_project_igw
  ]

  tags = {
    Name = "cloudswitch360_project_private_db_subnet-az1b"
  }
}

#Create AWS EIP for NAT Gateway in the public subnet of AZ 1a.
# Ensure you name the EIP to nat_gateway_eip-az1a to match the naming convention.
resource "aws_eip" "cloudswitch360_nat_gateway_eip-az1a" {
  domain = "vpc"

  tags = {
    Name = "cloudswitch360_project_nat_gateway_eip-az1a"
  }
}

# Create a NAT Gateway in the public subnet of AZ 1a.
# Ensure you name the NAT Gateway to nat_gateway-az1a to match the naming convention.
resource "aws_nat_gateway" "cloudswitch360_nat_gateway-az1a" {
  allocation_id = aws_eip.cloudswitch360_nat_gateway_eip-az1a.id
  subnet_id     = aws_subnet.cloudswitch360_project_public_subnet-az1a.id

  tags = {
    Name = "cloudswitch360_project_nat_gateway-az1a"
  }

  depends_on = [aws_internet_gateway.cloudswitch360_project_igw,
  aws_subnet.cloudswitch360_project_public_subnet-az1a]
}

# Create a Public Route Table for the public subnets.
# Ensure you name the route table to public_route_table-az1a to match the naming convention.
resource "aws_route_table" "cloudswitch360_pub_rt" {
  vpc_id = aws_vpc.cloudswitch360_project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cloudswitch360_project_igw.id
  }

  tags = {
    Name = "Route Table for Public Subnets"
  }
}

# associate the public route table with the public subnets in AZ 1a and AZ 1b.
resource "aws_route_table_association" "public_subnet_association_az1a" {
  subnet_id      = aws_subnet.cloudswitch360_project_public_subnet-az1a.id
  route_table_id = aws_route_table.cloudswitch360_pub_rt.id
}

# associate the public route table with the public subnets in AZ 1b.
resource "aws_route_table_association" "public_subnet_association_az1b" {
  subnet_id      = aws_subnet.cloudswitch360_project_public_subnet-az1b.id
  route_table_id = aws_route_table.cloudswitch360_pub_rt.id
}

# Create a Private Route Table for the private subnets.
# Ensure you name the route table to private_route_table-az1a to match the naming convention.
resource "aws_route_table" "cloudswitch360_private_rt" {
  vpc_id = aws_vpc.cloudswitch360_project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.cloudswitch360_nat_gateway-az1a.id
  }

  tags = {
    Name = "Route Table for Private Subnets"
  }
}

# associate the private route table with the private subnets in AZ 1a
resource "aws_route_table_association" "private_app_subnet_association_az1a" {
  subnet_id      = aws_subnet.cloudswitch360_project_private_app_subnet-az1a.id
  route_table_id = aws_route_table.cloudswitch360_private_rt.id
}

# associate the orivarte route table with a private database subnet in AZ 1a
resource "aws_route_table_association" "private_db_subnet_association_az1a" {
  subnet_id      = aws_subnet.cloudswitch360_project_private_db_subnet-az1a.id
  route_table_id = aws_route_table.cloudswitch360_private_rt.id
}

# associate the private route table with the private subnets in AZ 1b
resource "aws_route_table_association" "private_app_subnet_association_az1b" {
  subnet_id      = aws_subnet.cloudswitch360_project_private_app_subnet-az1b.id
  route_table_id = aws_route_table.cloudswitch360_private_rt.id
}

# associate the private route table with the private database subnet in AZ 1b
resource "aws_route_table_association" "private_db_subnet_association_az1b" {
  subnet_id      = aws_subnet.cloudswitch360_project_private_db_subnet-az1b.id
  route_table_id = aws_route_table.cloudswitch360_private_rt.id
}

/*

NOTE: For your capstone project, you will segregate route tables based on the private app subnets and private database subnets.
You will create a route table for the private app subnets and a separate route table for the private database subnets. This will allow you to manage routing rules independently for each type of subnet, providing better control over network traffic and security.

*/