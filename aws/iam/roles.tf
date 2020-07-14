locals {
  // transform list to map in order to use for_each instead of count
  //  so that we can reference roles by name from other resources
  //  and maps get indexed by strings instead of integers, which makes it more readable and debuggable
  roles = {for role in var.roles:
    role.name => role
  }

  tmp_roles_aws_managed_policies = flatten([ for role in var.roles:
    [for policy_name in role.policies_names_aws_managed:
      {
        role_name: role.name,
        policy_name: policy_name,
      }
    ] if length(role.policies_names_aws_managed) > 0
  ])

  roles_aws_managed_policies = { for role in local.tmp_roles_aws_managed_policies:
    "${role.role_name}_${role.policy_name}" => role
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

  role       = aws_iam_role.role[each.value.role_name].name
  policy_arn = "arn:aws:iam::aws:policy/${each.value.policy_name}"
}
