resource "aws_cognito_user_pool" "user_pool" {
  name = "test_user_pool"

  username_attributes = ["email"]
  password_policy {
    minimum_length = 6
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject        = "Account Confirmation"
    email_message        = "Your verification code is {####}"
  }

  auto_verified_attributes = ["email"]

  tags = {
    name = "test_user_pool-awab"
  }
}

resource "aws_cognito_user_pool_client" "client" {
  name                          = "test-cognito-client"
  user_pool_id                  = aws_cognito_user_pool.user_pool.id
  generate_secret               = false
  refresh_token_validity        = 90
  prevent_user_existence_errors = "ENABLED"
  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]
}
