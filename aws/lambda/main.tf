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

resource "aws_iam_role_policy" "lambda_cloudwatch" {
  name   = "lambda-cloudwatch-write-${var.function_name}"
  role   = aws_iam_role.lambda.id
  policy = data.aws_iam_policy_document.lambda_cloudwatch.json
}

data "aws_iam_policy_document" "lambda_cloudwatch" {
  statement {
    actions   = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
}
