
resource "aws_s3_bucket" "bucket_name" {
  bucket = var.BUCKET_NAME
  force_destroy = true
  tags = {
    Name        = var.BUCKET_NAME
    Environment = "Dev"
  }
}

#resource "aws_s3_bucket_acl" "b_acl" {
#  bucket = aws_s3_bucket.bucket_name.id
  #control_object_ownership = true
 # object_ownership         = "ObjectWriter"
 # acl    = "public-read"
#}

resource "aws_s3_bucket_website_configuration" "s3_website" {
  bucket = aws_s3_bucket.bucket_name.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

