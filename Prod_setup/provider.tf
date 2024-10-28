terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
#Backend Configration

terraform {
  backend "s3" {
    bucket = "tfstatefile-s3-store-acc2" # Backet name (Unique)
    key    = "eks_terraform.tfstate"     # name of the file in Bucket
    region = "us-east-1"
  }
}