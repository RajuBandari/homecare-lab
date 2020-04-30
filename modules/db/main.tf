resource "aws_dynamodb_table" "dynamo_table_user" {
  name           = "User"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "userId"
  range_key      = "email"

  attribute {
    name = "userId"
    type = "S"
  }

  attribute {
    name = "email"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-table-user"
    Environment = "production"
  }
}

resource "aws_dynamodb_table" "dynamo_table_vitals" {
  name           = "Vital"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "id"
  range_key      = "age"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "age"
    type = "S"
  }

  attribute {
    name = "userId"
    type = "S"
  }

  global_secondary_index {
    name               = "vitals-user-index"
    hash_key           = "userId"
    range_key          = "age"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["userId"]
  }

  tags = {
    Name        = "dynamodb-table-vitals"
    Environment = "production"
  }
}

resource "aws_dynamodb_table" "dynamo_table_prescriptions" {
  name           = "Prescription"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "id"
  range_key      = "date"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "date"
    type = "S"
  }

  attribute {
    name = "userId"
    type = "S"
  }

  global_secondary_index {
    name               = "prescription-user-index"
    hash_key           = "userId"
    range_key          = "date"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["userId"]
  }

  tags = {
    Name        = "dynamodb-table-prescriptions"
    Environment = "production"
  }
}