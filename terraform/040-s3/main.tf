resource "aws_s3_bucket" "db_backups" {
  bucket = "tfg-marta-db-backups" 

  tags = {
    Name = "TFG DB Backups"
    Proyecto = "TFG-ASIR-DAW"
  }
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.db_backups.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket    = aws_s3_bucket.db_backups.id
  block_public_acls = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}
