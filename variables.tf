# Cloudflare
variable "cloudflare_api_token" {
  sensitive = true
}


# Hetzner Cloud
variable "hcloud_token" {
  sensitive = true
}


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


# Common resource tags
variable "additional_tags" {
  type    = map(string)
  default = {}
}
