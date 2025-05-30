output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.example.bucket
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.example.id
}