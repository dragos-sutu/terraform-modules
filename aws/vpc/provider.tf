terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}

  experiments = [variable_validation]
}

provider "aws" {
  region = var.aws_region
}
