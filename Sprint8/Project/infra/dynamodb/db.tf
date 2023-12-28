resource "aws_dynamodb_table" "students" {
  name             = "students"
  hash_key         = "student_id"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = false
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "student_id"
    type = "S"
  }
  tags = {
    Name = "students"
    Owner = "Awab"
  }
}