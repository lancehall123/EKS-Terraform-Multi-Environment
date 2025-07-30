terraform {
  backend "s3" {
    bucket         = "terraform-eks-state-lance"
    key            = "prod/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-eks-state-lance-locks"
    encrypt        = true
  }
}
