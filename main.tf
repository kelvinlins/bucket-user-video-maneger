provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  versioning {
    enabled = true  # Ativa versionamento no S3
  }
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.id
}
