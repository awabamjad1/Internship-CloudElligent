resource "aws_iam_role" "ec2" {
  name = "ec2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}
resource "aws_iam_policy" "ec2" {
  name        = "ec2"

  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1699611820868",
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Sid": "Stmt1699611851402",
      "Action": "ec2:*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
})
}
resource "aws_iam_role_policy_attachment" "ecr_role_attachment" {
  policy_arn = aws_iam_policy.ec2.arn
  role       = aws_iam_role.ec2.name
}
resource "aws_iam_instance_profile" "ec2" {
  name = "EC2"
  role = aws_iam_role.ec2.name
}