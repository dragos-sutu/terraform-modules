resource "aws_lambda_function" "lambda" {
  filename         = var.payload_zip_path
  function_name    = var.function_name
  handler          = var.handler
  publish          = true
  role             = aws_iam_role.lambda.arn
  runtime          = var.runtime
  source_code_hash = filebase64sha256(var.payload_zip_path)

  tags = merge({
    Name = "${var.function_name}.lambda",
  }, var.tags)
}

resource "aws_iam_role" "lambda" {
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
  name               = "lambda-${var.function_name}"
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role_policy_attachment" "lambda_cloudwatch" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda.id
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/aws/lambda/${aws_lambda_function.lambda.function_name}"
  retention_in_days = 30
}
