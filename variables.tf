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

variable "txt_records" {
  type    = map(string)
  default = {}
}

# Common resource tags
variable "additional_tags" {
  type    = map(string)
  default = {}
}
