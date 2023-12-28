resource "aws_lambda_function" "dbtest" {
  depends_on = [ data.archive_file.dbtest ]
  function_name    = "dbtest"
  filename         = "dbtest.zip"
  handler          = "index.lambda_handler"
  runtime          = "python3.8"
  timeout = 15

  environment {
    variables = {
      testenv = "value123"
    }
  }
  role = "${aws_iam_role.lambda_exec.arn}"
}