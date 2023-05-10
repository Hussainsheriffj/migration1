terraform {
  backend "s3" {
    bucket         = "talent-academy-hussainsheriff-lab-tfstates"
    key            = "talent-academy/migration/terraform.tfstates"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}