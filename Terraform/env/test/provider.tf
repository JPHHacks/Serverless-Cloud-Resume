terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = "us-east-1"  # or your preferred region for test    
  profile = "test-main"  # or your AWS profile for testing 
}