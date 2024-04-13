terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
        }
    }

    backend "s3" {
        bucket = "tduong10101-terraform-state-bucket"
        key    = "valheim_state"
        region = "ap-southeast-2"
    }
}

# Configure the AWS Provider
provider "aws" {
    region = "ap-southeast-2"
}


