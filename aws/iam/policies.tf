locals {
  // transform list to map in order to use for_each instead of count
  //  so that terraform state maps get indexed by strings instead of integers,
  //  makes it more readable and debuggable
  policies = {for policy in var.policies:
    policy.name => policy
  }
}

resource "aws_iam_policy" "policy" {
  for_each = local.policies

  description = each.value.description
  name        = each.value.name
  policy      = data.aws_iam_policy_document.policy[each.key].json
}

data "aws_iam_policy_document" "policy" {
  for_each = local.policies

  statement {
    actions   = ["sts:AssumeRole"]
    effect    = "Allow"
    resources = each.value.resources
  }
}
