output "user_pool_id" {
  value = aws_cognito_user_pool.pool.id
}

output "clients_ids" {
  value = { for client in aws_cognito_user_pool_client.clients:
    client.name => {
      "client_secret": client.client_secret,
      "id": client.id
    }
  }
}

