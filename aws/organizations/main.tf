locals {
  # change var.organizational_units type to map,
  # so that we can reference aws_organizations_organizational_unit
  # by name (map key) in aws_organizations_account blocks
  organizational_units = zipmap(var.organizational_units, var.organizational_units)
}

resource "aws_organizations_organization" "org" {
  feature_set = "ALL"
}

resource "aws_organizations_account" "account" {
  count = length(var.accounts)

  email     = var.accounts[count.index].email
  name      = var.accounts[count.index].name
  parent_id = aws_organizations_organizational_unit.ou[var.accounts[count.index].organizational_unit].id
}

resource "aws_organizations_organizational_unit" "ou" {
  for_each = local.organizational_units

  name      = each.key
  parent_id = aws_organizations_organization.org.roots.0.id
}
