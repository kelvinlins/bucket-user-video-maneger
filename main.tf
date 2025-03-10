provider "aws" {
  region = var.aws_region
}

# Criando o Bucket S3
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  versioning {
    enabled = true  # Ativa versionamento no S3
  }
}

resource "aws_s3_bucket_notification" "evento_s3" {
  bucket = aws_s3_bucket.bucket.bucket

  eventbridge = true  # Configura a notificação para o EventBridge

  # Pode adicionar outros tipos de notificações aqui, como SNS ou SQS, se necessário
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.id
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.bucket.bucket

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "s3:PutObject"
        Principal = "*"
        Resource  = "${aws_s3_bucket.bucket.arn}/*"
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_cloudwatch_event_rule.minha_regra.arn
          }
        }
      }
    ]
  })
}
