output "function_arn" {
  value = aws_lambda_function.lambda.arn
}

output "function_version" {
  value = aws_lambda_function.lambda.version
}
