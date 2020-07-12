output "accounts" {
  value = { for account in aws_organizations_account.account:
    account.name => account.id
  }
}
