output "bucket_name" {
  value = aws_s3_bucket.db_backups.bucket
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.db_backups.arn
}