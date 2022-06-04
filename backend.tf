

terraform {
  backend "s3" {
    bucket         = "state-lock"
    region         = "ap-south-1"
    key            = "terraform.tfstate"
    dynamodb_table = "state-lock"
    
  }
}
