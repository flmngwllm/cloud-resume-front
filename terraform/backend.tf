terraform {
  backend "s3" {
  bucket = var.BUCKET_NAME
  key = "terraform/backend"
  region = var.REGION
  }
}