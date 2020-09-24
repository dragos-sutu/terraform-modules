terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

provider "aws" {
  region = var.aws_region
}

// This module is tailored for Cloudfront, the certificate has to be in us-east-1 for Cloudfront distributions
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
