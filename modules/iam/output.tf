output "assume_role_name" {
  value = "${aws_iam_role.lambda_assume_role.arn}"
}
