terraform {
  required_version = ">= 1.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
    null = {
      source = "hashicorp/null"
    }
  }

  backend "s3" {
    bucket = "magiclab396-terraform-on-aws-eks"
    key    = "dev/argocd/terraform.tfstate"
    region = "ap-southeast-1" 

    # For State Locking
    dynamodb_table = "dev-argocd"    
  }     
}