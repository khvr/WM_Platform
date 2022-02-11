# Email validation
module "acm_email" {
    count = var.use_acm_email_validation == true ? 1 : 0
  source = "../../modules/acm"

  domain_name = var.domain_name
  zone_id     = local.zone_name

  subject_alternative_names = [
    "*.${var.domain_name}",
  ]

  validation_method = "EMAIL"
    wait_for_validation = true
  tags = {
    Name = var.domain_name
  }
}

# DNS Validation
module "acm_dns" {
    count = var.use_acm_email_validation == false ? 1 : 0
  source = "../../modules/acm"
    domain_name = var.domain_name
    zone_id     = local.zone_id

    subject_alternative_names = [
        "*.${var.domain_name}"
    ]

    wait_for_validation = true

    tags = {
        Name = var.domain_name
    }
}