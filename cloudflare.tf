resource "cloudflare_zone" "nightspotlight_me" {
  zone = var.cloudflare_zone_name

  plan   = "free"
  paused = false
}

resource "cloudflare_record" "A" {
  for_each = var.a_records

  zone_id = var.cloudflare_zone_id

  type    = "A"
  name    = each.key
  value   = each.value["address"]
  proxied = each.value["proxied"]
}

resource "cloudflare_record" "AAAA" {
  for_each = var.aaaa_records

  zone_id = var.cloudflare_zone_id

  type    = "AAAA"
  name    = each.key
  value   = each.value["address"]
  proxied = each.value["proxied"]
}

resource "cloudflare_record" "CNAME" {
  for_each = var.cname_records

  zone_id = var.cloudflare_zone_id

  type    = "CNAME"
  name    = each.key
  value   = each.value["address"]
  proxied = each.value["proxied"]
}

resource "cloudflare_record" "NS" {
  for_each = transpose(var.ns_records)

  zone_id = var.cloudflare_zone_id

  type  = "NS"
  name  = each.value[0]
  value = each.key
}

resource "cloudflare_zone_settings_override" "nightspotlight_me_settings" {
  zone_id = var.cloudflare_zone_id

  settings {
    # SSL/TLS
    ssl                      = "strict"
    always_use_https         = "on"
    automatic_https_rewrites = "on"
    security_header { enabled = false }
    opportunistic_encryption = "on"
    opportunistic_onion      = "off"
    min_tls_version          = "1.1"
    tls_1_3                  = "zrt"
    tls_client_auth          = "off"

    # Firewall
    security_level = "medium"
    browser_check  = "on"
    privacy_pass   = "on"

    # Speed
    minify {
      css  = "off"
      html = "off"
      js   = "off"
    }
    brotli        = "on"
    rocket_loader = "off"
    mobile_redirect {
      status           = "off"
      mobile_subdomain = ""
      strip_uri        = false
    }

    # Caching
    cache_level      = "aggressive"
    always_online    = "off"
    development_mode = "off"

    # Network
    ipv6           = "on"
    pseudo_ipv4    = "off"
    ip_geolocation = "off"
    websockets     = "on"

    # Scrape Shield
    email_obfuscation   = "on"
    server_side_exclude = "off"
    hotlink_protection  = "on"
  }
}
