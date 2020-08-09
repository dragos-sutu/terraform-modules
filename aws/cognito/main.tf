locals {
  clients = {for client in var.clients:
    client.name => client
  }

  explicit_auth_flows = []
}

resource "aws_cognito_user_pool" "pool" {
  auto_verified_attributes = ["email"]

  email_configuration {
    email_sending_account  = "DEVELOPER"
    from_email_address     = var.from_email_address
    reply_to_email_address = var.reply_to_email_address
    source_arn             = var.from_email_address_arn
  }

  lambda_config {
    custom_message = var.lambda_trigger_custom_message_arn
  }

  name = var.user_pool_name

  dynamic "schema" {
    for_each = var.user_pool_standard_attributes

    content {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = schema.value["mutable"]
      name                     = schema.value["name"]
      required                 = true

      string_attribute_constraints {
        max_length = "2048"
        min_length = "0"
      }
    }
  }

  username_attributes = ["email"]

  username_configuration {
    case_sensitive = false
  }

  tags = merge({
    Name = "${var.user_pool_name}.userpool.cognito",
  }, var.tags)
}

resource "aws_cognito_user_pool_client" "clients" {
  for_each = local.clients

  callback_urls                = each.value.callback_urls
  explicit_auth_flows          = each.value.explicit_auth_flows
  generate_secret              = each.value.generate_secret
  logout_urls                  = each.value.logout_urls
  name                         = each.value.name
  refresh_token_validity       = each.value.refresh_token_validity
  supported_identity_providers = ["COGNITO"]
  user_pool_id                 = aws_cognito_user_pool.pool.id
}
