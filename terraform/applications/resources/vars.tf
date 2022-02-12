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

variable "name_prefix" {
  description = "customize name prefix based of app usecase"
  type = string
  default = "SPA"
}

variable "cors_origins" {
  description = "The domain which are whitelisted for cors"
  type = string
}

variable "cors_methods" {
  description = "The allowed methods for the cors origins"
  type = list(string)
  default = ["GET"]
}