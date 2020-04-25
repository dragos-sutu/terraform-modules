resource "aws_organizations_account" "identity" {
  email     = var.account_identity.email
  name      = var.account_identity.name
  parent_id = aws_organizations_organizational_unit.sre.id
}

resource "aws_organizations_account" "non_prod" {
  email     = var.account_non_prod.email
  name      = var.account_non_prod.name
  parent_id = aws_organizations_organizational_unit.developers.id
}
