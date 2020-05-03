output "password" {
  value = aws_iam_user_login_profile.administrator.encrypted_password
}
