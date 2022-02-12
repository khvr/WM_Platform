variable "region" {
  description = "Enter AWS region. Eg: us-east-1"
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
  description = "To use email for dns validation for acm enter true or enter false. Accepted values[true, false]"
  type = bool
}

variable "name_prefix" {
  description = "customize name prefix based of app usecase"
  type = string
  default = "SPA"
}

variable "cors_origins" {
  description = "The domain which are whitelisted for cors. eg: http://example.com"
  type = string
}

variable "cors_methods" {
  description = "The allowed methods for the cors origins"
  type = list(string)
  default = ["GET"]
}