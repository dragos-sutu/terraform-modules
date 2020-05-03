resource "aws_organizations_organization" "org" {
  enabled_policy_types = ["SERVICE_CONTROL_POLICY", "TAG_POLICY"]
  feature_set = "ALL"
}
