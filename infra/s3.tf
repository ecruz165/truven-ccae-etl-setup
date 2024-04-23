
resource "aws_s3_bucket" "truven-source-storage" {
  bucket = "truven-columbia-dbmi"
}

resource "aws_s3_object" "folder_raw" {
  bucket = aws_s3_bucket.truven-source-storage.bucket
  key    = "raw/"
}

resource "aws_s3_object" "folder_cdmCSV" {
  bucket = aws_s3_bucket.truven-source-storage.bucket
  key    = "cdmCSV/"
}



resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "lambda_s3_access" {
  name   = "lambda_s3_access_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
        ]
        Effect = "Allow"
        Resource = [
          "${aws_s3_bucket.truven-source-storage.arn}/*",
        ]
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_s3_access_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_s3_access.arn
}


# resource "aws_s3_bucket" "truven-bucket" {
#   bucket = "bucket"
# }
# resource "aws_s3_bucket" "truven-messages-bucket" {
#   bucket = "messages_bucket"
# }
# resource "aws_s3_bucket" "truven-messages-bucket-merge" {
#   bucket = "messages_bucket_merge"
# }

# #Create Lambda Permission
# resource "aws_lambda_permission" "allow_bucket" {
#   statement_id  = "AllowExecutionFromS3Bucket"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.example_lambda.function_name
#   principal     = "s3.amazonaws.com"
#   source_arn    = "arn:aws:s3:::bucket_name_here" // Replace with your bucket's ARN
# }

# #Create Bucket NOtification 
# resource "aws_s3_bucket_notification" "bucket_notification" {
#   bucket = aws_s3_bucket.truven-bucket.bucket

#   lambda_function {
#     lambda_function_arn = aws_lambda_function.example_lambda.arn
#     events              = ["s3:ObjectCreated:Put"]
#     filter_prefix       = "" // Use if you want to limit to specific prefixes
#     filter_suffix       = "" // Use if you want to limit to specific suffixes
#   }
# }
