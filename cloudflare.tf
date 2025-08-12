resource "cloudflare_zone" "nightspotlight_me" {
  account_id = "04132b11b075606d0abf885c6257d12f"
  zone       = "nightspotlight.me"
  plan       = "free"
  paused     = false
}

resource "cloudflare_zone_settings_override" "nightspotlight_me_settings" {
  zone_id = cloudflare_zone.nightspotlight_me.id

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
    brotli        = "on"
    rocket_loader = "off"

    # Caching
    cache_level      = "aggressive"
    always_online    = "off"
    development_mode = "off"

    # Network
    ipv6           = "on"
    pseudo_ipv4    = "off"
    ip_geolocation = "off"
    websockets     = "on"
    http2          = "on"
    http3          = "on"
    zero_rtt       = "on"

    # Scrape Shield
    email_obfuscation   = "on"
    server_side_exclude = "off"
    hotlink_protection  = "on"
  }
}

moved {
  from = cloudflare_record.A
  to   = module.dns.cloudflare_record.A
}
moved {
  from = cloudflare_record.AAAA
  to   = module.dns.cloudflare_record.AAAA
}
moved {
  from = cloudflare_record.CNAME
  to   = module.dns.cloudflare_record.CNAME
}
moved {
  from = cloudflare_record.NS
  to   = module.dns.cloudflare_record.NS
}
moved {
  from = cloudflare_record.TXT
  to   = module.dns.cloudflare_record.TXT
}
