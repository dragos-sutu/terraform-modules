locals {
  // transform list to map in order to use for_each instead of count
  //  so that terraform state maps get indexed by strings instead of integers,
  //  makes it more readable and debuggable
  groups = { for group in var.groups:
    group.name => group
  }

  tmp_groups_aws_managed_policies = flatten([ for group in var.groups:
    [ for policy_arn in group.policies_aws_managed_arns:
      {
        group_name: group.name,
        policy_arn: policy_arn,
      }
    ] if length(group.policies_aws_managed_arns) > 0
  ])

  groups_aws_managed_policies = { for group in local.tmp_groups_aws_managed_policies:
    group.group_name => group
  }

  tmp_groups_customer_managed_policies = flatten([ for group in var.groups:
    [ for policy_name in group.policies_customer_managed_names:
      {
        group_name: group.name,
        policy_name: policy_name,
      }
    ] if length(group.policies_customer_managed_names) > 0
  ])

  groups_customer_managed_policies = { for group in local.tmp_groups_customer_managed_policies:
    group.group_name => group
  }
}

resource "aws_iam_group" "group" {
  for_each = local.groups

  name = each.value.name
}

resource "aws_iam_group_policy_attachment" "aws_managed" {
  for_each = local.groups_aws_managed_policies

  group      = aws_iam_group.group[each.key].name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "customer_managed" {
  for_each = local.groups_customer_managed_policies

  group      = aws_iam_group.group[each.key].name
  policy_arn = aws_iam_policy.policy[each.value.policy_name].arn
}
