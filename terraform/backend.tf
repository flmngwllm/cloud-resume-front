terraform {
  backend "s3" {
  bucket = "williamofleming"
  key = "terraform/backend"
  region = "us-east-1"
  }
}