# Cloudflare
variable "cloudflare_email" {}

variable "cloudflare_account_id" {
  sensitive = true
}

variable "cloudflare_api_key" {
  sensitive = true
}

variable "cloudflare_zone_name" {
  default = "nightspotlight.me"
}

variable "cloudflare_zone_id" {
  default = "682b27e4ca7465c29bc00a9d1b0876c3"
}


# Hetzner Cloud
variable "hcloud_token" {
  sensitive = true
}

# variable "hetznerdns_token" {
#   sensitive = true
# }


# Additional DNS resources
variable "a_records" {
  type    = map(object({ address = string, proxied = bool }))
  default = {}
}

variable "aaaa_records" {
  type    = map(object({ address = string, proxied = bool }))
  default = {}
}

variable "cname_records" {
  type    = map(object({ address = string, proxied = bool }))
  default = {}
}

variable "ns_records" {
  type    = map(list(string))
  default = {}
}
