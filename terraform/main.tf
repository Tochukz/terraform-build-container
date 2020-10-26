terraform {
#  backend "s3" {}
}

provider "aws" {
  region  = "eu-west-1"
  version = "~> 3"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  query_id_hash_key = "QueryId"
  ttl_attribute     = "TTL"
}


resource "aws_dynamodb_table" "query-store" {
  name         = "example-query-store"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = local.query_id_hash_key

  attribute {
    name = local.query_id_hash_key
    type = "S"
  }

  attribute {
    name = local.ttl_attribute
    type = "S"
  }

  ttl {
    attribute_name = local.ttl_attribute
    enabled        = true
  }

  global_secondary_index {
    name            = "TTL_Index"
    hash_key        = local.ttl_attribute
    projection_type = "ALL"
  }

  server_side_encryption {
    enabled = true
  }

  tags = module.label.tags
}
