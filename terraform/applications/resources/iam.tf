

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = 1
    actions = [
      "s3:GetObject"
    ]
    principals {
      type        = "AWS"
      identifiers = [module.cloudfront.cloudfront_origin_access_identity_iam_arns[0]]
    }
    resources = [
        module.wm_s3.s3_bucket_arn,
      "${module.wm_s3.s3_bucket_arn}/*"
    ]
  }
}