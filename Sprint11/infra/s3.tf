resource "aws_s3_bucket" "this" {
  bucket = "apptestawab"
  force_destroy = true
}