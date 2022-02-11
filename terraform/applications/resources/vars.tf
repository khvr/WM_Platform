variable "region" {
  description = "AWS region"
  type        = string
}

variable "domain_name" {
  description = "Custom domain name for spa"
  type = string
}

variable "index_document" {
  description = "index document for static hosting"
  type = string
  default = "index.html"
}

variable "error_document" {
  description = "error document for static hosting"
  type = string
  default = "index.html"
}
variable "use_acm_email_validation" {
  description = "controls acm validation method"
  type = bool
  default = false
}