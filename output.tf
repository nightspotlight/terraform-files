# output "ip_addresses" {
#   value = [
#     hcloud_server.main.ipv4_address,
#     "${hcloud_server.main.ipv6_address}1"
#   ]
# }

output "cloudflare_zone_status" {
  value = [
    "Zone: ${cloudflare_zone.nightspotlight_me.zone}",
    "Status: ${cloudflare_zone.nightspotlight_me.status}",
    "Paused: ${cloudflare_zone.nightspotlight_me.paused}",
    "Phishing detected: ${cloudflare_zone.nightspotlight_me.meta.phishing_detected}"
  ]
}
