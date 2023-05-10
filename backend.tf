terraform {
  backend "s3" {
    bucket         = "talent-academy-hussainsheriff-lab-tfstates1"
    key            = "talent-academy/migration/terraform.tfstates1"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}