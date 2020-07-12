locals {
  accounts = { for account in var.accounts:
    account.name => account
  }
}

resource "aws_organizations_organization" "org" {
  enabled_policy_types = ["SERVICE_CONTROL_POLICY", "TAG_POLICY"]
  feature_set = "ALL"
}

resource "aws_organizations_organizational_unit" "ou" {
  for_each = var.organizational_units

  name      = each.value
  parent_id = aws_organizations_organization.org.roots.0.id
}

resource "aws_organizations_account" "account" {
  for_each = local.accounts

  email     = each.value.email
  name      = each.value.name
  parent_id = aws_organizations_organizational_unit.ou[each.value.organizational_unit].id
}
