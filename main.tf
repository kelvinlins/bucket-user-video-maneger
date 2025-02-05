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

lifecycle {
    create_before_destroy = true  # Garante que o recurso será substituído antes de ser destruído
}

# Configuração para notificar o EventBridge quando um arquivo for enviado para o S3
resource "aws_s3_bucket_notification" "evento_s3" {
  bucket = aws_s3_bucket.bucket.id

  eventbridge {
    # Configuração para enviar eventos para o EventBridge
  }
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.id
}
