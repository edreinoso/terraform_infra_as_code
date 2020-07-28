terraform {
  backend "s3" {
    bucket         = "terraform-state-er"
    dynamodb_table = "terraform-state-lock-dynamo"
    region         = "us-east-1"
    key            = "terraform_templates/template-1-autoscaling.tfstate"
  }
}