variable "cloudflare_email" {}
variable "cloudflare_account_id" {}
variable "cloudflare_api_key" {}

variable "hcloud_token" {}

variable "zone_name" { default = "nightspotlight.me" }

variable "zone_id" { default = "682b27e4ca7465c29bc00a9d1b0876c3" }

variable "aaaa_records" {
  type = list(object({name = string, address = string, proxied = bool}))
  default = []
}

variable "ns_records" {
  type = map(list(string))
  default = {}
}
