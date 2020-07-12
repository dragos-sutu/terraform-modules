output "password" {
  value = [ for profile in aws_iam_user_login_profile.profile:
    {
      user: profile.user,
      password: profile.encrypted_password,
    }
  ]
}
