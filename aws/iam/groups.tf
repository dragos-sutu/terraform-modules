locals {
  // transform list to map in order to use for_each instead of count
  //  so that we can reference groups by name from other resources
  //  and maps get indexed by strings instead of integers, which makes it more readable and debuggable
  groups = { for group in var.groups:
    group.name => group
  }

  tmp_groups_aws_managed_policies = flatten([ for group in var.groups:
    [ for policy_name in group.policies_names_aws_managed:
      {
        group_name: group.name,
        policy_name: policy_name,
      }
    ] if length(group.policies_names_aws_managed) > 0
  ])

  groups_aws_managed_policies = { for group in local.tmp_groups_aws_managed_policies:
    "${group.group_name}_${group.policy_name}" => group
  }

  tmp_groups_customer_managed_policies = flatten([ for group in var.groups:
    [ for policy_name in group.policies_names_customer_managed:
      {
        group_name: group.name,
        policy_name: policy_name,
      }
    ] if length(group.policies_names_customer_managed) > 0
  ])

  groups_customer_managed_policies = { for group in local.tmp_groups_customer_managed_policies:
    "${group.group_name}_${group.policy_name}" => group
  }
}

resource "aws_iam_group" "group" {
  for_each = local.groups

  name = each.value.name
}

resource "aws_iam_group_policy_attachment" "aws_managed" {
  for_each = local.groups_aws_managed_policies

  group      = aws_iam_group.group[each.value.group_name].name
  policy_arn = "arn:aws:iam::aws:policy/${each.value.policy_name}"
}

resource "aws_iam_group_policy_attachment" "customer_managed" {
  for_each = local.groups_customer_managed_policies

  group      = aws_iam_group.group[each.value.group_name].name
  policy_arn = aws_iam_policy.policy[each.value.policy_name].arn
}
