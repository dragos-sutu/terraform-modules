locals {
  managed_accounts_ids = jsonencode([
    for account_id in var.managed_accounts_ids : "arn:aws:iam::${account_id}:role/administratorAccess"
  ])
}

resource "aws_iam_user" "administrator" {
  name          = "administrator"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "administrator" {
  user    = aws_iam_user.administrator.name
  pgp_key = var.pgp_key
}

resource "aws_iam_group" "cross-accounts-administrators" {
  name = "cross-accounts-administrators"
}

resource "aws_iam_group_policy_attachment" "administrator-access" {
  group      = aws_iam_group.cross-accounts-administrators.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "cross-accounts-administrator-access" {
  group      = aws_iam_group.cross-accounts-administrators.name
  policy_arn = aws_iam_policy.cross-accounts-administrator.arn
}

resource "aws_iam_policy" "cross-accounts-administrator" {
  name        = "cross-accounts-administrator"
  description = "Allows AssumeRole administratorAccess in managed accounts"
  policy      = templatefile(
    "${path.module}/files/policy-cross-accounts-administrator.tmpl",
    { resources = local.managed_accounts_ids }
  )
}

resource "aws_iam_user_group_membership" "administrator" {
  user = aws_iam_user.administrator.name

  groups = [
    aws_iam_group.cross-accounts-administrators.name,
  ]
}
