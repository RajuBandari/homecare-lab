variable "function_name" {
  description = "name of the file name where the lambda fuction is - function name"
}

variable "handler" {
  description = "entrypoint function in the code"
}

variable "source_file_path" {
  description = "source file of the lambda implementation"
}

variable "runtime" {
  description = "runtime environment for the lambda function handler"
  default = "nodejs10.x"
}

variable "table_name" {
  description = "dynamo table name for lambda function"
}

variable "role" {
  description = "IAM role attched to the lambda function"
}




