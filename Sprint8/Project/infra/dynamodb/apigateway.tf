resource "aws_api_gateway_rest_api" "studentdb" {
  name        = "studentdb"
  description = "REST API Gateway for PetReunite backend"
}
resource "aws_api_gateway_deployment" "studentdb" {
  depends_on = [ 
  aws_api_gateway_integration.studentdb
  ]  
  rest_api_id = "${aws_api_gateway_rest_api.studentdb.id}"
  stage_name  = "test"
}
#------------------------------------------------------------------------------
resource "aws_api_gateway_resource" "studentdb" {
  rest_api_id = "${aws_api_gateway_rest_api.studentdb.id}"
  parent_id   = "${aws_api_gateway_rest_api.studentdb.root_resource_id}"
  path_part   = "studentdb"
}
resource "aws_api_gateway_method" "studentdb" {
  rest_api_id   = "${aws_api_gateway_rest_api.studentdb.id}"
  resource_id   = "${aws_api_gateway_resource.studentdb.id}"
  http_method   = "ANY"
  authorization = "NONE"
}
resource "aws_api_gateway_integration" "studentdb" {
  rest_api_id = "${aws_api_gateway_rest_api.studentdb.id}"
  resource_id = "${aws_api_gateway_method.studentdb.resource_id}"
  http_method = "${aws_api_gateway_method.studentdb.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.dbtest.invoke_arn}"
}
resource "aws_lambda_permission" "studentdb" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.dbtest.function_name}"
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.studentdb.execution_arn}/*/*"
}

