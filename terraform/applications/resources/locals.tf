locals{
    zone_name = sort(keys(module.zones.route53_zone_zone_id))[0]
     zone_id = module.zones.route53_zone_zone_id["${var.domain_name}"]
    tags = {
        ManagedBy = "Terraform"
    }
}