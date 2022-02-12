module "cloudfront" {
  source = "../../modules/cloudfront"

  aliases = ["${var.domain_name}"]

  comment             = "SPA CloudFront"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  default_root_object = var.index_document
  retain_on_delete    = false
  wait_for_deployment = true
    web_acl_id = module.waf.web_acl_arn
  # When you enable additional metrics for a distribution, CloudFront sends up to 8 metrics to CloudWatch in the US East (N. Virginia) Region.
  # This rate is charged only once per month, per metric (up to 8 metrics per distribution).
#   create_monitoring_subscription = true

  create_origin_access_identity = true
  origin_access_identities = {
    spa_s3_oai = "OAI for ${var.domain_name}"
  }


  origin = {
    spa_s3 = {
      domain_name = module.wm_s3.s3_bucket_bucket_regional_domain_name
      origin_id   = module.wm_s3.s3_bucket_bucket_regional_domain_name
    s3_origin_config = {
        origin_access_identity = "spa_s3_oai" # key in `origin_access_identities`
        # cloudfront_access_identity_path = "origin-access-identity/cloudfront/E5IGQAA1QO48Z" # external OAI resource
      }
      origin_shield = {
        enabled              = true
        origin_shield_region = var.region
      }
    }
  }


  default_cache_behavior = {
    target_origin_id       = module.wm_s3.s3_bucket_bucket_regional_domain_name
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    query_string           = true

    # This is id for SecurityHeadersPolicy copied from https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-response-headers-policies.html
    response_headers_policy_id = "67f7725c-6f97-4210-82d7-5512b31e9d03"


    use_forwarded_values = true
    headers      = []
    query_string = true
    cookies_forward = "all"
    
  }

  viewer_certificate = {
    acm_certificate_arn =  var.use_acm_email_validation ? module.acm_email[0].acm_certificate_arn : module.acm_dns[0].acm_certificate_arn
    ssl_support_method  = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  geo_restriction = {
    restriction_type = "whitelist"
    locations        = ["NO", "UA", "US", "GB"]
  }

}