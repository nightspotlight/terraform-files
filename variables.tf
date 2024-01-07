# Cloudflare
variable "cloudflare_api_token" {
  sensitive = true
}

# Hetzner Cloud
variable "hcloud_token" {
  sensitive = true
}

# Common resource tags
variable "additional_tags" {
  type    = map(string)
  default = {}
}
