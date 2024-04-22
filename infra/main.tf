provider "aws" {
  region = "us-east-1"
  profile = "truven"
}


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


# resource "aws_security_group" "vpn_security_group" {
#   name        = "vpn-security-group"
#   description = "Security group for VPN connections"
#   vpc_id = "vpc-0e3d67b310b1e2721"  # Replace with your VPC ID
#   tags = {
#     "Name" = "IICTR-Truven"
#   }

#   // Define ingress and egress rules for VPN connections
#   ingress {
#     from_port   = 3389
#     to_port     = 3389
#     protocol    = "tcp"
#     cidr_blocks = ["10.144.220.0/24"]  # Allow TCP traffic from any source
#     description = "VDI"
#   }
#   ingress {
#     from_port   = 3389
#     to_port     = 3389
#     protocol    = "tcp"
#     cidr_blocks = ["156.145.105.0/24"]  # Allow TCP traffic to any destination
#   }
#   egress {
#     from_port = 0
#     to_port = 0
#     protocol    = -1  # All protocols
#     cidr_blocks = ["0.0.0.0/0"]  # Allow TCP traffic to any destination
#   }
# }


# resource "aws_instance" "truven-desktop" {
#   ami           = "ami-00135ef04a6fea471"
#   instance_type = "t3.large"
#   vpc_security_group_ids = [aws_security_group.vpn_security_group.id]  # Use an empty list if no security groups are specified
#   subnet_id     = "subnet-0ad6bb838b7a2a865"  # Specify the subnet ID where you want to launch the instance
#   key_name      = "Win2022SAS_truven"  # Specify the name of your key pair
#   ebs_optimized = true
#   tags = {
#     "Name" = "IICTR-Truven"
#   }

#   ebs_block_device {
#     device_name = "xvdf"  # Specify the device name as "xvdf"
#     volume_type = "gp2"
#     volume_size = 50
#     delete_on_termination = false
#   }
# }
