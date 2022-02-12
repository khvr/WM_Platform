module "zones" {
  source = "../../modules/route53/zones"
  zones = {
    "${var.domain_name}" = {
      comment           = "${var.domain_name} (production)"
      tags = local.tags
    }
  }
}

module "route53_records" {
  source = "../../modules/route53/records"

  zone_name = local.zone_name
  #  zone_id = local.zone_id

  records = [
    {
      name = "" # leave blank for just the domain, execute one record at a time
      type = "TXT"
      ttl = 30
      records = [
          "Hello from ${var.domain_name}"
      ]
    },
    {
      name = "" # leave blank for just the domain, execute one record at a time
      type = "A"
      alias = {
        name = module.cloudfront.cloudfront_distribution_domain_name
        zone_id = module.cloudfront.cloudfront_distribution_hosted_zone_id
        evaluate_target_health = true
      }
    }
  ]
  depends_on = [module.zones]
}
