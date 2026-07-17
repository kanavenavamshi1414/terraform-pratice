resource "aws_iam_role" "lambda_role" {
  name = var.lambda_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


resource "aws_lambda_function" "python_function" {
  function_name = var.lambda_function_name

  role    = aws_iam_role.lambda_role.arn
  runtime = var.lambda_runtime
  handler = "python.py.lambda_handler"

  s3_bucket = var.s3_bucket_name
  s3_key    = var.s3_key

  

  timeout     = var.lambda_timeout
  memory_size = var.lambda_memory_size
}