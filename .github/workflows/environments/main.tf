terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Next step: Add cloud resources here
# 1. Create the Main Isolated Network VPC
resource "aws_vpc" "dev_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "dev-enterprise-vpc"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

# 2. Create Public Subnet 1 (For Internet-facing applications/Load Balancers)
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "dev-public-subnet-1a"
    Type = "Public"
  }
}

# 3. Create Private Subnet 1 (Secure zone for Payment systems/Databases)
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "dev-private-subnet-1a"
    Type = "Private"
  }
}

# 4. Create an Internet Gateway to connect the public subnet to the web
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "dev-vpc-igw"
  }
}
