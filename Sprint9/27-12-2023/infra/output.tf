output "user_pool_id" {
  description = "ID of the AWS Cognito User Pool"
  value       = aws_cognito_user_pool.user_pool.id
}

output "user_pool_client_id" {
  description = "ID of the AWS Cognito User Pool Client"
  value       = aws_cognito_user_pool_client.client.id
}