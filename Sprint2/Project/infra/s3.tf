resource "aws_s3_bucket" "this" {
  bucket = "apptestawab"
  force_destroy = true
}
/*resource "aws_s3_bucket_object" "this" {
  depends_on = [ aws_s3_bucket.this ]
  bucket = "apptestawab"
  key    = "docker-compose.yml" 
  acl    = "private"
} */