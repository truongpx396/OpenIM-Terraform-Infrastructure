
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "magiclab396-terraform-on-aws-eks"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = "ap-southeast-1"
  }
}
