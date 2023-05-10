resource "aws_s3_bucket" "state_file_bucket" {
    bucket = "talent-academy-hussainsheriff-lab-tfstates1"

    tags = {
        Name = "talent-academy-hussainsheriff-lab-tfstates1"
        Environment = "Lab"
    }

    lifecycle {
        prevent_destroy = true
    }
}

resource "aws_kms_key" "s3-sse-c" {
  description             = "This key is used to encrypt bucket objects"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.state_file_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.s3-sse-c.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "version_my_bucket" {
    bucket = aws_s3_bucket.state_file_bucket.id

    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_dynamodb_table" "terraform_lock_tbl" {
  name           = "terraform-lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags           = {
    Name = "terraform-lock"
  }
}
