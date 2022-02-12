module "cloudfront" {
  source = "../../modules/cloudfront"

  aliases = ["${var.domain_name}"]

  comment             = "SPA CloudFront"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = true

  # When you enable additional metrics for a distribution, CloudFront sends up to 8 metrics to CloudWatch in the US East (N. Virginia) Region.
  # This rate is charged only once per month, per metric (up to 8 metrics per distribution).
#   create_monitoring_subscription = true

#   create_origin_access_identity = true
#   origin_access_identities = {
#     comment = "OAI for ${var.domain_name}"
#   }


  origin = {
    # spa = {
    #   domain_name = module.wm_s3.s3_bucket_website_endpoint
    #   origin_id   = module.wm_s3.s3_bucket_website_endpoint

    # #   origin_shield = {
    # #     enabled              = true
    # #     origin_shield_region = var.region
    # #   }
    # }
    spa = {
    domain_name = module.wm_s3.s3_bucket_website_endpoint
    origin_id   = module.wm_s3.s3_bucket_website_endpoint
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      }
    }
  }


  default_cache_behavior = {
    target_origin_id       = module.wm_s3.s3_bucket_website_endpoint
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