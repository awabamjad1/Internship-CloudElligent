resource "aws_api_gateway_rest_api" "wordreversal" {
  name        = "wordreversal"
  description = "REST API Gateway for PetReunite backend"
}
resource "aws_api_gateway_deployment" "wordreversal" {
  depends_on = [ 
  aws_api_gateway_integration.wordreversal
  ]  
  rest_api_id = "${aws_api_gateway_rest_api.wordreversal.id}"
  stage_name  = "test"
}
#------------------------------------------------------------------------------
resource "aws_api_gateway_resource" "wordreversal" {
  rest_api_id = "${aws_api_gateway_rest_api.wordreversal.id}"
  parent_id   = "${aws_api_gateway_rest_api.wordreversal.root_resource_id}"
  path_part   = "wordreversal"
}
resource "aws_api_gateway_method" "wordreversal" {
  rest_api_id   = "${aws_api_gateway_rest_api.wordreversal.id}"
  resource_id   = "${aws_api_gateway_resource.wordreversal.id}"
  http_method   = "ANY"
  authorization = "NONE"
}
resource "aws_api_gateway_integration" "wordreversal" {
  rest_api_id = "${aws_api_gateway_rest_api.wordreversal.id}"
  resource_id = "${aws_api_gateway_method.wordreversal.resource_id}"
  http_method = "${aws_api_gateway_method.wordreversal.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.testfunc.invoke_arn}"
}
resource "aws_lambda_permission" "wordreversal" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.testfunc.function_name}"
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.wordreversal.execution_arn}/*/*"
}
