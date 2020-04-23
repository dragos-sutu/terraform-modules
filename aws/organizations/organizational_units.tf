
resource "aws_organizations_organizational_unit" "identity" {
  name      = "Identity"
  parent_id = aws_organizations_organization.org.roots.0.id
}

resource "aws_organizations_organizational_unit" "dev" {
  name      = "Dev"
  parent_id = aws_organizations_organization.org.roots.0.id
}
