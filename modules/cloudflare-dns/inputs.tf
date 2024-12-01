variable "zone_id" {
  type = string
}

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

variable "mx_records" {
  type    = map(object({ address = string, priority = number }))
  default = {}
}

variable "ns_records" {
  type    = map(list(string))
  default = {}
}

variable "txt_records" {
  type    = map(string)
  default = {}
}
