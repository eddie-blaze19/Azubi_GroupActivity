# Example S3 bucket with security configurations
resource "aws_s3_bucket" "example" {
  bucket = "${var.project_name}-${var.environment}-bucket-${random_id.bucket_suffix.hex}"
  
  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Example EC2 instance (intentionally misconfigured for demonstration)
resource "aws_instance" "example" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2
  instance_type = "t2.micro"
  
  # Intentionally missing security group for Conformity to catch
  
  tags = {
    Name        = "${var.project_name}-${var.environment}-instance"
    Environment = var.environment
  }
}