terraform {
  backend "s3" {
    bucket         = "jpheymannweb-terraform-state"
    key            = "test/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}