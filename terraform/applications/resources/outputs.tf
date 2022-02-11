output "domain_registrar_ns" {
    description = "Name servers of Route53 zone"
    value       = module.zones.route53_zone_name_servers
}