resource "aws_route53_zone" "primary" {
  name         = var.DOMAIN_NAME
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.${var.DOMAIN_NAME}.com"
  type    = "CNAME"
  ttl     = 300
  records = [aws_cloudfront_distribution.s3_distribution.domain_name]
}


resource "aws_route53_record" "apex" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.DOMAIN_NAME
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.zone_id
    evaluate_target_health = false
  }
}