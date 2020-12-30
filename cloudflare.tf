resource "cloudflare_zone" "nightspotlight_me" {
  zone = var.cloudflare_zone_name

  plan   = "free"
  paused = false
}

resource "cloudflare_record" "AAAA" {
  count = length(var.aaaa_records)

  zone_id = var.cloudflare_zone_id

  type    = "AAAA"
  name    = lookup(var.aaaa_records[count.index], "name")
  value   = lookup(var.aaaa_records[count.index], "address")
  proxied = lookup(var.aaaa_records[count.index], "proxied")
}

resource "cloudflare_record" "NS" {
  count = length(keys(transpose(var.ns_records)))

  zone_id = var.cloudflare_zone_id

  type  = "NS"
  name  = element(flatten(values(transpose(var.ns_records))), count.index)
  value = element(keys(transpose(var.ns_records)), count.index)
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
