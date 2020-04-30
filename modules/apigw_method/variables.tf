variable "rest_api_id" {
  description       = "restful api id"
}

variable "resource_id" {
  description       = "resouce id"
}

variable "region" {
  description       = "aws region"
  default           = "us-east-1"    
}

variable "lambda" {
  description       = "aws lambda function id"
}

variable "path" {
  description       = "rest api path"
}

variable "method" {
  description       = "http method name"
  default           = "GET"
}

variable "account_id" {
  description       = "AWS accountId"
}

