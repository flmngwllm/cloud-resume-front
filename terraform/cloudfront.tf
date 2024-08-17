
resource "aws_cloudfront_origin_access_control" "S3_OAC" {
  name              = "s3_static-oac"
  origin_access_control_type = "s3"
  signing_behavior  = "always"
  signing_protocol  = "sigv4"
  comment           = "OAC for S3 bucket ${var.bucket_name}"
}


locals {
  s3_origin_id = "S3-${var.BUCKET_NAME}"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.bucket_name.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.S3_OAC.id
    origin_id                = local.s3_origin_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${var.DOMAIN_NAME} cloudfront distibution"
  default_root_object = "index.html"

  logging_config {
    include_cookies = false
    bucket          = "mylogs.s3.amazonaws.com"
    prefix          = "myprefix"
  }


  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = []
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
  acm_certificate_arn            = aws_acm_certificate.certificate.arn
  ssl_support_method             = "sni-only"
  minimum_protocol_version       = "TLSv1.2_2021"
}

}