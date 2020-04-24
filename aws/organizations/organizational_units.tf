
resource "aws_organizations_organizational_unit" "sre" {
  name      = "SRE"
  parent_id = aws_organizations_organization.org.roots.0.id
}

resource "aws_organizations_organizational_unit" "developers" {
  name      = "Developers"
  parent_id = aws_organizations_organization.org.roots.0.id
}
