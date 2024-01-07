resource "cloudflare_record" "A" {
  for_each = var.a_records

  zone_id = var.zone_id

  type    = "A"
  name    = each.key
  value   = each.value["address"]
  proxied = each.value["proxied"]
}

resource "cloudflare_record" "AAAA" {
  for_each = var.aaaa_records

  zone_id = var.zone_id

  type    = "AAAA"
  name    = each.key
  value   = each.value["address"]
  proxied = each.value["proxied"]
}

resource "cloudflare_record" "CNAME" {
  for_each = var.cname_records

  zone_id = var.zone_id

  type    = "CNAME"
  name    = each.key
  value   = each.value["address"]
  proxied = each.value["proxied"]
}

resource "cloudflare_record" "NS" {
  for_each = transpose(var.ns_records)

  zone_id = var.zone_id

  type  = "NS"
  name  = each.value[0]
  value = each.key
}

resource "cloudflare_record" "TXT" {
  for_each = var.txt_records

  zone_id = var.zone_id

  type  = "TXT"
  name  = each.key
  value = each.value
}
