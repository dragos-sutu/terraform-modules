locals {
  // transform list to map in order to use for_each instead of count
  //  so that terraform state maps get indexed by strings instead of integers,
  //  makes it more readable and debuggable
  roles = {for role in var.roles:
    role.name => role
  }

  tmp_roles_aws_managed_policies = flatten([for role in var.roles:
    [for policy_arn in role.policies_aws_managed_arns:
      {
        role_name: role.name,
        policy_arn: policy_arn,
      }
    ] if length(role.policies_aws_managed_arns) > 0
  ])

  roles_aws_managed_policies = {for role in local.tmp_roles_aws_managed_policies:
    role.role_name => role
  }
}

resource "aws_iam_role" "role" {
  for_each = local.roles

  assume_role_policy   = data.aws_iam_policy_document.role[each.key].json
  max_session_duration = 43200
  name                 = each.value.name
}

data "aws_iam_policy_document" "role" {
  for_each = local.roles

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      identifiers = ["arn:aws:iam::${each.value.trusted_account}:root"]
      type        = "AWS"
    }
  }
}

resource "aws_iam_role_policy_attachment" "aws_managed" {
  for_each = local.roles_aws_managed_policies

  role       = aws_iam_role.role[each.key].name
  policy_arn = each.value.policy_arn
}
