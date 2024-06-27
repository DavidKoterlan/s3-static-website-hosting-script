# S3 Bucket
resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = {
    Name = var.bucket_name
  }
}

# Public Access Block Configuration
resource "aws_s3_bucket_public_access_block" "bucket_public_access_block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

# Delay execution to ensure the bucket is fully ready
resource "null_resource" "wait_for_bucket" {
  provisioner "local-exec" {
    command = "sleep 10"
  }
  depends_on = [aws_s3_bucket.bucket]
}

# Bucket Policy
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket     = aws_s3_bucket.bucket.id
  depends_on = [aws_s3_bucket.bucket, null_resource.wait_for_bucket]

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowPublicReadAccess",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::${aws_s3_bucket.bucket.id}/*"
      }
    ]
  })
}

