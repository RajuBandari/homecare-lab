provider "aws" {
  region              = "${var.aws_region}"
  access_key          = "${var.aws_access_key}"
  secret_key          = "${var.aws_secrete_key}"
}

data "aws_caller_identity" "current" { }

module "iam_profiles" {
  source              = "./modules/iam"
  assume_role_name    = "lambda_assume_role"
}

# DB
module "database" {
  source = "./modules/db"
}


# Lambda

# User APIs
module "user_profile" {
    source            = "./modules/lambda"
    source_file_path  = "./src/users/userInfo.js"
    function_name     = "userInfo"
    handler           = "userInfo"
    runtime           = "nodejs10.x"
    role              = "${module.iam_profiles.assume_role_name}"
    table_name        = "User"
}

module "user_profile_post" {
    source            = "./modules/lambda"
    source_file_path  = "./src/users/postUserInfo.js"
    function_name     = "postUserInfo"
    handler           = "postUserInfo"
    runtime           = "nodejs10.x"
    role              = "${module.iam_profiles.assume_role_name}"
    table_name        = "User"
}

# Vitals APIs

module "vitals_get" {
    source            = "./modules/lambda"
    source_file_path  = "./src/vitals/getVitals.js"
    function_name     = "getVitals"
    handler           = "getVitals"
    runtime           = "nodejs10.x"
    role              = "${module.iam_profiles.assume_role_name}"
    table_name        = "Vital"
}

module "vitals_post" {
    source            = "./modules/lambda"
    source_file_path  = "./src/vitals/postVitals.js"
    function_name     = "postVitals"
    handler           = "postVItals"
    runtime           = "nodejs10.x"
    role              = "${module.iam_profiles.assume_role_name}"
    table_name        = "Vital"
}

module "vitals_put" {
    source            = "./modules/lambda"
    source_file_path  = "./src/vitals/putVitals.js"
    function_name     = "putVitals"
    handler           = "putVitals"
    runtime           = "nodejs10.x"
    role              = "${module.iam_profiles.assume_role_name}"
    table_name        = "Vital"
}

# Prescriptions APIs

module "prescriptions_get" {
    source            = "./modules/lambda"
    source_file_path  = "./src/prescriptions/getPrescription.js"
    function_name     = "getPrescription"
    handler           = "getPrescription"
    runtime           = "nodejs10.x"
    role              = "${module.iam_profiles.assume_role_name}"
    table_name        = "Prescription"
}

module "prescriptions_post" {
    source            = "./modules/lambda"
    source_file_path  = "./src/prescriptions/postPrescription.js"
    function_name     = "postPrescription"
    handler           = "postPrescription"
    runtime           = "nodejs10.x"
    role              = "${module.iam_profiles.assume_role_name}"
    table_name        = "Prescription"
}




# API Gateway
resource "aws_api_gateway_rest_api" "apigw" {
  name          = "homecare"
}

resource "aws_api_gateway_resource" "apigw_resource" {
  rest_api_id   = "${aws_api_gateway_rest_api.apigw.id}"
  parent_id     = "${aws_api_gateway_rest_api.apigw.root_resource_id}"
  path_part     = "profile"
}

resource "aws_api_gateway_resource" "apigw_vitals_resource" {
  rest_api_id   = "${aws_api_gateway_rest_api.apigw.id}"
  parent_id     = "${aws_api_gateway_rest_api.apigw.root_resource_id}"
  path_part     = "vitals"
}

resource "aws_api_gateway_resource" "apigw_prescriptions_resource" {
  rest_api_id   = "${aws_api_gateway_rest_api.apigw.id}"
  parent_id     = "${aws_api_gateway_rest_api.apigw.root_resource_id}"
  path_part     = "prescriptions"
}


# user - api methods
module "apigw_user_profile" {
  source        = "./modules/apigw_method"
  rest_api_id   = "${aws_api_gateway_rest_api.apigw.id}"
  resource_id   = "${aws_api_gateway_resource.apigw_resource.id}"
  method        = "GET"
  path          = "${aws_api_gateway_resource.apigw_resource.path}"
  lambda        = "${module.user_profile.function_name}"
  account_id    = "${data.aws_caller_identity.current.account_id}"
}

module "apigw_user_profile_post" {
  source        = "./modules/apigw_method"
  rest_api_id   = "${aws_api_gateway_rest_api.apigw.id}"
  resource_id   = "${aws_api_gateway_resource.apigw_resource.id}"
  method        = "POST"
  path          = "${aws_api_gateway_resource.apigw_resource.path}"
  lambda        = "${module.user_profile_post.function_name}"
  account_id    = "${data.aws_caller_identity.current.account_id}"
}

# vitals - api methods

module "apigw_vitals_get" {
  source        = "./modules/apigw_method"
  rest_api_id   = "${aws_api_gateway_rest_api.apigw.id}"
  resource_id   = "${aws_api_gateway_resource.apigw_vitals_resource.id}"
  method        = "GET"
  path          = "${aws_api_gateway_resource.apigw_vitals_resource.path}"
  lambda        = "${module.vitals_get.function_name}"
  account_id    = "${data.aws_caller_identity.current.account_id}"
}

module "apigw_vitals_post" {
  source        = "./modules/apigw_method"
  rest_api_id   = "${aws_api_gateway_rest_api.apigw.id}"
  resource_id   = "${aws_api_gateway_resource.apigw_vitals_resource.id}"
  method        = "POST"
  path          = "${aws_api_gateway_resource.apigw_vitals_resource.path}"
  lambda        = "${module.vitals_post.function_name}"
  account_id    = "${data.aws_caller_identity.current.account_id}"
}

module "apigw_vitals_put" {
  source        = "./modules/apigw_method"
  rest_api_id   = "${aws_api_gateway_rest_api.apigw.id}"
  resource_id   = "${aws_api_gateway_resource.apigw_vitals_resource.id}"
  method        = "PUT"
  path          = "${aws_api_gateway_resource.apigw_vitals_resource.path}"
  lambda        = "${module.vitals_put.function_name}"
  account_id    = "${data.aws_caller_identity.current.account_id}"
}

# prescriptions - api methods

module "apigw_prescriptions_get" {
  source        = "./modules/apigw_method"
  rest_api_id   = "${aws_api_gateway_rest_api.apigw.id}"
  resource_id   = "${aws_api_gateway_resource.apigw_prescriptions_resource.id}"
  method        = "GET"
  path          = "${aws_api_gateway_resource.apigw_prescriptions_resource.path}"
  lambda        = "${module.prescriptions_get.function_name}"
  account_id    = "${data.aws_caller_identity.current.account_id}"
}

module "apigw_prescriptions_put" {
  source        = "./modules/apigw_method"
  rest_api_id   = "${aws_api_gateway_rest_api.apigw.id}"
  resource_id   = "${aws_api_gateway_resource.apigw_prescriptions_resource.id}"
  method        = "POST"
  path          = "${aws_api_gateway_resource.apigw_prescriptions_resource.path}"
  lambda        = "${module.prescriptions_post.function_name}"
  account_id    = "${data.aws_caller_identity.current.account_id}"
}

resource "aws_api_gateway_deployment" "apigw_deployment" {
  rest_api_id     = "${aws_api_gateway_rest_api.apigw.id}"
  stage_name      = "prod"
  description     = "Deploy methods: ${module.apigw_user_profile.http_method} ${module.apigw_user_profile_post.http_method}"
}




