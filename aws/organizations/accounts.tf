resource "aws_organizations_account" "identity" {
  email     = var.account_identity.email
  name      = var.account_identity.name
  parent_id = aws_organizations_organizational_unit.sre.id
}

resource "aws_organizations_account" "dev" {
  email     = var.account_dev.email
  name      = var.account_dev.name
  parent_id = aws_organizations_organizational_unit.developers.id
}
