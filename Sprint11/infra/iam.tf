resource "aws_iam_role" "ec2_private" {
  name = "ec2_private"

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
}
resource "aws_iam_policy" "ec2_private" {
  name        = "ec2_Private"
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
resource "aws_iam_role_policy_attachment" "ec2_private" {
  policy_arn = aws_iam_policy.ec2_private.arn
  role       = aws_iam_role.ec2_private.name
}
resource "aws_iam_instance_profile" "Ec2_Private" {
  name = "EC2instance_Private"
  role = aws_iam_role.ec2_private.name
}
#-----------------------------------------------------------------------------------------
resource "aws_iam_role" "ec2_public" {
  name = "ec2_public"

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
}
resource "aws_iam_policy" "ec2_public" {
  name        = "ec2_Public"
  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1699611851402",
      "Action": "ec2:*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
})
}
resource "aws_iam_role_policy_attachment" "ec2_public" {
  policy_arn = aws_iam_policy.ec2_public.arn
  role       = aws_iam_role.ec2_public.name
}
resource "aws_iam_instance_profile" "ec2_public" {
  name = "EC2instance_Public"
  role = aws_iam_role.ec2_public.name
}