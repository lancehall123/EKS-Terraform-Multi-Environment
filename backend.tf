terraform {
  backend "s3" {
    bucket         = "terraform-eks-state-lance"
    region         = "eu-west-1"
    dynamodb_table = "terraform-eks-state-lance-locks"
    key = "terraform/dev/terraform.tfstate"
  }
}
