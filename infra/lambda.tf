provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_function" "notification_forwarder" {
  function_name = "aws-controltower-NotificationForwarder"
  handler       = "index.lambda_handler"
  role          = "arn:aws:iam::992382423790:role/aws-controltower-ForwardSnsNotificationRole"
  runtime       = "python3.9"
  s3_bucket     = "cdm-builder-setup-files"
  s3_key        = "lambda-artifacts/aws-controltower-NotificationForwarder.zip"

  description     = "SNS message forwarding function for aggregating account notifications."
  memory_size     = 128
  timeout         = 60
  package_type    = "Zip"
  architectures   = ["x86_64"]
  ephemeral_storage {
    size = 512
  }

  environment {
    variables = {
      sns_arn = "arn:aws:sns:us-east-1:001101278786:aws-controltower-AggregateSecurityNotifications"
    }
  }

  tracing_config {
    mode = "PassThrough"
  }
}

resource "aws_lambda_function" "cdm_builder" {
  function_name = "CDMBuilder"
  handler       = "org.ohdsi.cdm.presentation.lambdabuilder::org.ohdsi.cdm.presentation.lambdabuilder.Function::FunctionHandler"
  role          = "arn:aws:iam::992382423790:role/lambda_execution_role"
  runtime       = "dotnet8"
  s3_bucket     = "cdm-builder-setup-files"
  s3_key        = "lambda-artifacts/CDMBuilder.zip"

  memory_size     = 256
  timeout         = 10
  package_type    = "Zip"
  architectures   = ["arm64"]
  ephemeral_storage {
    size = 512
  }

  tracing_config {
    mode = "PassThrough"
  }

  logging_config {
    log_format = "Text"
    log_group = "/aws/lambda/CDMBuilder"
  }
}

resource "aws_lambda_function" "merge" {
  function_name = "Merge"
  handler       = "org.ohdsi.cdm.presentation.lambdamerge::org.ohdsi.cdm.presentation.lambdamerge.Function::FunctionHandler"
  role          = "arn:aws:iam::992382423790:role/lambda_execution_role"
  runtime       = "dotnet8"
  s3_bucket     = "cdm-builder-setup-files"
  s3_key        = "lambda-artifacts/Merge.zip"

  memory_size     = 256
  timeout         = 10
  package_type    = "Zip"
  architectures   = ["arm64"]
  ephemeral_storage {
    size = 512
  }

  tracing_config {
    mode = "PassThrough"
  }

  logging_config {
    log_format = "Text"
    log_group = "/aws/lambda/Merge"
  }
}
