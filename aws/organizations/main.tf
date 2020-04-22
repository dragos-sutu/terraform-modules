terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

provider "aws" {
  region = var.aws_region
}

resource "aws_organizations_organization" "organization" {
  feature_set = "ALL"
}

resource "aws_organizations_account" "child_account" {
  count = length(var.accounts)

  email = var.accounts[count.index].email
  name  = var.accounts[count.index].name
}
