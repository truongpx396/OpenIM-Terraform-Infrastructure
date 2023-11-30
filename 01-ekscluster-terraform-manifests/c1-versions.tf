# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 3.70"
      version = ">= 4.65"
     }
    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "magiclab396-terraform-on-aws-eks"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = "ap-southeast-1" 
 
    # For State Locking
    dynamodb_table = "dev-ekscluster"    
  }  
}

# Terraform Provider Block
provider "aws" {
  region = var.aws_region
}

provider "template" {
  # Configuration options
}