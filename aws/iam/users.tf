locals {
  // transform list to map in order to use for_each instead of count
  //  so that terraform state maps get indexed by strings instead of integers,
  //  makes it more readable and debuggable
  users = { for user in var.users:
    user.name => user
  }

  user_login_profiles = { for user in var.users:
    user.name => {
      name: user.name,
      pgp_key: user.pgp_key,
    } if user.login_profile
  }
}

resource "aws_iam_user" "user" {
  for_each = local.users

  name          = each.value.name
  force_destroy = true
}

resource "aws_iam_user_login_profile" "profile" {
  for_each = local.user_login_profiles

  user    = aws_iam_user.user[each.key].name
  pgp_key = each.value.pgp_key
}

resource "aws_iam_user_group_membership" "membership" {
  for_each = local.users

  groups = each.value.groups_names
  user   = each.value.name

  depends_on = [
    aws_iam_group.group,
    aws_iam_user.user,
  ]
}
