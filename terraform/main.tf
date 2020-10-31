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

resource "aws_s3_bucket_public_access_block" "vpc_flowlogs_s3_bucket_public_access_block" {
  bucket                  = aws_s3_bucket.vpc_flowlogs_s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "aqm_lambda_functions" {

  bucket = "aqm-lambda-functions"
  acl    = "private"
}
