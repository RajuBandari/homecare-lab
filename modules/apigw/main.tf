resource "aws_api_gateway_rest_api" "apigw" {
  name          = "${var.rest_api_name}"
}

resource "aws_api_gateway_resource" "apigw_resource" {
  rest_api_id   = "${aws_api_gateway_rest_api.apigw.id}"
  parent_id     = "${aws_api_gateway_rest_api.apigw.root_resource_id}"
  path_part     = "${var.path}"
}

resource "aws_api_gateway_deployment" "apigw_deployment" {
  rest_api_id = "${var.rest_api_id}"
  stage_name = "${var.stage}"
  description = "api deployment"
}


