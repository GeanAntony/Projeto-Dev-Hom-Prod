provider "aws" {
  region = "us-west-2" # Change to your desired region
}

# S3 Bucket for Static Website
resource "aws_s3_bucket" "frontend" {
  bucket = "my-static-website-bucket"
  website {
    index_document = "index.html"
  }
}

# CloudFront Distribution
resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = aws_s3_bucket.frontend.website_endpoint
    origin_id   = "S3-Frontend"
  }

  enabled = true

  default_cache_behavior {
    target_origin_id = "S3-Frontend"
    viewer_protocol_policy = "redirect-to-https"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  price_class = "PriceClass_100"
}

# Cognito User Pool
resource "aws_cognito_user_pool" "auth" {
  name = "user-pool"
}

# API Gateway
resource "aws_api_gateway_rest_api" "api" {
  name        = "api-gateway"
  description = "API Gateway for the application"
}

# Lambda Function
resource "aws_lambda_function" "lambda_func" {
  filename         = "function.zip"
  function_name    = "business-logic"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.handler"
  runtime          = "nodejs14.x"
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"
  
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
#
#
# RDS Instance
resource "aws_db_instance" "db_rds" {
  identifier = "rds-instance"
  instance_class = "db.t2.micro"
  engine = "postgres"
  allocated_storage = 20
  username = "dbadmin"
  password = "password"
  db_name = "mydb"
}

# DynamoDB Table
resource "aws_dynamodb_table" "db_nosql" {
  name           = "my-table"
  hash_key       = "id"
  billing_mode   = "PAY_PER_REQUEST"
  attribute {
    name = "id"
    type = "S"
  }
}

# SQS Queue
resource "aws_sqs_queue" "queue" {
  name = "message-queue"
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "logging" {
  name = "application-logs"
}

# Output for reference
output "s3_bucket" {
  value = aws_s3_bucket.frontend.bucket
}

output "cloudfront_distribution" {
  value = aws_cloudfront_distribution.cdn.id
}

output "cognito_user_pool" {
  value = aws_cognito_user_pool.auth.id
}

output "api_gateway" {
  value = aws_api_gateway_rest_api.api.id
}

output "lambda_function" {
  value = aws_lambda_function.lambda_func.arn
}

output "rds_instance" {
  value = aws_db_instance.db_rds.endpoint
}

output "dynamodb_table" {
  value = aws_dynamodb_table.db_nosql.name
}

output "sqs_queue" {
  value = aws_sqs_queue.queue.id
}

output "cloudwatch_log_group" {
  value = aws_cloudwatch_log_group.logging.name
}
