output "route53_record_name" {
  description = "The name of the record"
  value       = { for k, v in aws_route53_record.ha_aws_route53_record : k => v.name }
}

output "route53_record_fqdn" {
  description = "FQDN built using the zone domain and name"
  value       = { for k, v in aws_route53_record.ha_aws_route53_record : k => v.fqdn }
}