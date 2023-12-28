module "template_files" {
    source = "hashicorp/dir/template"

    base_dir = "${path.module}/web"
}


resource "aws_s3_bucket" "hosting_bucket" {
    bucket = var.bucket_name
}
resource "aws_s3_bucket_public_access_block" "access" {
  bucket = aws_s3_bucket.hosting_bucket.id

  block_public_acls   = false
  block_public_policy = false
}
/*
resource "aws_iam_policy" "s3_policy" {
  name        = "S3BucketPolicyExample"
  description = "Allows necessary actions on the S3 bucket"
  
  # Define your policy document here
  policy = jsonencode({
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"AddPerm",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["*"]
    }
  ]
})
}

resource "aws_s3_bucket_policy" "example_bucket_policy" {
  bucket = aws_s3_bucket.hosting_bucket.id
  policy = aws_iam_policy.s3_policy.policy
}
*/
resource "aws_s3_bucket_website_configuration" "hosting_bucket_website_configuration" {
    bucket = aws_s3_bucket.hosting_bucket.id

    index_document {
      suffix = "index.html"
    }
}

resource "aws_s3_object" "hosting_bucket_files" {
    bucket = aws_s3_bucket.hosting_bucket.id

    for_each = module.template_files.files

    key = each.key
    content_type = each.value.content_type

    source  = each.value.source_path
    content = each.value.content

    etag = each.value.digests.md5
}