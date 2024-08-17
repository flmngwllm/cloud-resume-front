
resource "aws_s3_bucket" "bucket_name" {
  bucket = var.BUCKET_NAME

  tags = {
    Name        = var.BUCKET_NAME
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "b_acl" {
  bucket = aws_s3_bucket.bucket_name.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "s3_website" {
  bucket = aws_s3_bucket.bucket_name.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}

resource "aws_s3_bucket_policy" "s3_policy" {
  bucket = aws_s3_bucket.bucket_name.id
policy = jsonencode({
  Version = "2012-10-17"
  Statement = [
    {
      Action    = "s3:GetObject"
      Effect    = "Allow"
      Resource  = "${aws_s3_bucket.bucket_name.arn}/*"
      Principal = {
        AWS = "${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"
      }
    }
  ]
})
}