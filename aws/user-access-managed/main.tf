resource "aws_iam_role" "administrator-access" {
  name = "administratorAccess"

  assume_role_policy = templatefile(
    "${path.module}/files/policy-assume-role-administrator-access.tmpl",
    { trusted_entity = var.manager_account_id }
  )
}

resource "aws_iam_role_policy_attachment" "administrator-access" {
  role       = aws_iam_role.administrator-access.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
