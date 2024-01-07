provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

locals {
  nextcloud_a_record = {
    lookup(hcloud_server.nextcloud.labels, "dns_subdomain", "nextcloud") = {
      address = hcloud_primary_ip.nextcloud_ipv4.ip_address,
      proxied = lookup(hcloud_server.nextcloud.labels, "cf_proxied", "false")
    }
  }
  nextcloud_aaaa_record = {
    lookup(hcloud_server.nextcloud.labels, "dns_subdomain", "nextcloud") = {
      address = cidrhost("${hcloud_primary_ip.nextcloud_ipv6.ip_address}/64", 1),
      proxied = lookup(hcloud_server.nextcloud.labels, "cf_proxied", "false")
    }
  }
}

resource "cloudflare_zone" "nightspotlight_me" {
  account_id = "04132b11b075606d0abf885c6257d12f"
  zone       = "nightspotlight.me"
  plan       = "free"
  paused     = true
}

resource "cloudflare_record" "A" {
  for_each = merge(local.nextcloud_a_record, var.a_records)

  zone_id = cloudflare_zone.nightspotlight_me.id

  type    = "A"
  name    = each.key
  value   = each.value["address"]
  proxied = each.value["proxied"]
}

resource "cloudflare_record" "AAAA" {
  for_each = merge(local.nextcloud_aaaa_record, var.aaaa_records)

  zone_id = cloudflare_zone.nightspotlight_me.id

  type    = "AAAA"
  name    = each.key
  value   = each.value["address"]
  proxied = each.value["proxied"]
}

resource "cloudflare_record" "CNAME" {
  for_each = var.cname_records

  zone_id = cloudflare_zone.nightspotlight_me.id

  type    = "CNAME"
  name    = each.key
  value   = each.value["address"]
  proxied = each.value["proxied"]
}

resource "cloudflare_record" "NS" {
  for_each = transpose(var.ns_records)

  zone_id = cloudflare_zone.nightspotlight_me.id

  type  = "NS"
  name  = each.value[0]
  value = each.key
}

resource "cloudflare_record" "TXT" {
  for_each = var.txt_records

  zone_id = cloudflare_zone.nightspotlight_me.id

  type  = "TXT"
  name  = each.key
  value = each.value
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
    http2          = "on"
    http3          = "on"
    zero_rtt       = "on"

    # Scrape Shield
    email_obfuscation   = "on"
    server_side_exclude = "off"
    hotlink_protection  = "on"
  }
}
