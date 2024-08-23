
resource "aws_s3_bucket" "bucket_name" {
  bucket = var.BUCKET_NAME
  force_destroy = true
  tags = {
    Name        = var.BUCKET_NAME
    Environment = "Dev"
  }
}


resource "aws_s3_bucket_public_access_block" "initial" {
  bucket = aws_s3_bucket.bucket_name.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}



resource "aws_s3_bucket_public_access_block" "final" {
  depends_on = [aws_s3_bucket_policy.bucket_policy]

  bucket = aws_s3_bucket.bucket_name.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}



resource "aws_s3_bucket_website_configuration" "s3_website" {
  bucket = aws_s3_bucket.bucket_name.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}


resource "aws_s3_bucket_policy" "bucket_policy" {
  depends_on = [aws_s3_bucket_public_access_block.initial]

  bucket = aws_s3_bucket.bucket_name.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "s3:GetObject",
        Effect    = "Allow",
        Resource  = "arn:aws:s3:::${var.BUCKET_NAME}/*",
        Principal = "*",
        Condition = {
          StringLike = {
            "aws:Referer" = "https://${aws_cloudfront_distribution.s3_distribution.domain_name}/*"
          }
        }
      }
    ]
  })
}
