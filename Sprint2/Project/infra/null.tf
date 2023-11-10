resource "null_resource" "this" {
  depends_on = [aws_s3_bucket.this]

  provisioner "local-exec" {
    command = <<-EOT
      aws s3 cp docker-compose.yml s3://apptestawab/docker-compose.yml
    EOT
  }
}