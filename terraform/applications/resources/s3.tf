module "wm_s3" {
    source="../../modules/s3"
    bucket        = var.domain_name
    acl           = "private"
    force_destroy = true

    attach_policy = true
    policy        = data.aws_iam_policy_document.bucket_policy.json

    versioning = {
        status = "Suspended",
        mfa_delete = "Disabled"
    }

    website = {
        index_document = var.index_document
        error_document = var.error_document
    }

    cors_rule = [
        {
        allowed_methods = var.cors_methods
        allowed_origins = [var.cors_origins]
        allowed_headers = ["*"]
        expose_headers  = []
        max_age_seconds = 3000
        }
    ]

  
    server_side_encryption_configuration = {
        rule = {
        apply_server_side_encryption_by_default = {
            sse_algorithm     = "AES256"
        }
        }
    }

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

}