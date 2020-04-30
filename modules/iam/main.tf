resource "aws_iam_role" "lambda_assume_role" {
  name                      = "${var.assume_role_name}"
  assume_role_policy        = "${file("${path.module}/policies/lambda_assume_role_policy.json")}"
}

resource "aws_iam_policy" "lambda_logging" {
  name                      = "lambda_logging"
  path                      = "/"
  description               = "IAM policy for logging from a lambda"
  policy                    = "${file("${path.module}/policies/cw_logs.json")}"
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = "${aws_iam_role.lambda_assume_role.name}"
  policy_arn = "${aws_iam_policy.lambda_logging.arn}"
}