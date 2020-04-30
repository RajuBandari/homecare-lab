locals{
  lambda_zip_location = "${path.module}/outputs/${var.function_name}_archieve.zip"
}
data "archive_file" "zip_data" {
    type                      = "zip"
    source_file               = "${var.source_file_path}"
    output_path               = "${local.lambda_zip_location}"
}

resource "aws_lambda_function" "lambda" {
  filename                    = "${local.lambda_zip_location}"
  function_name               = "${var.function_name}_${var.handler}"
  handler                     = "${var.function_name}.handler"
  runtime                     = "${var.runtime}"
  role                        = "${var.role}"
  #source_code_hash           = "${filebase64sha256("lambda_function_payload.zip")}"

  depends_on                  = ["aws_cloudwatch_log_group.log_group"]
  
  environment {
    variables = {
      table_name = "${var.table_name}"
    }
  }
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 14
}
