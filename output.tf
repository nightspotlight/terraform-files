output "nextcloud_server" {
  description = "Nextcloud server status"
  value = [
    "Name: ${hcloud_server.nextcloud.name}",
    "Type: ${hcloud_server.nextcloud.server_type}",
    "Datacenter: ${hcloud_server.nextcloud.datacenter}",
    "Status: ${hcloud_server.nextcloud.status}"
  ]
}

output "nextcloud_server_ips" {
  description = "Nextcloud server IP addresses"
  value = [
    hcloud_server.nextcloud.ipv4_address,
    hcloud_server.nextcloud.ipv6_address
  ]
}

output "cloudflare_zone_status" {
  description = "Cloudflare zone status"
  value = [
    "Zone: ${cloudflare_zone.nightspotlight_me.zone}",
    "Status: ${cloudflare_zone.nightspotlight_me.status}",
    "Paused: ${cloudflare_zone.nightspotlight_me.paused}",
    "Phishing detected: ${cloudflare_zone.nightspotlight_me.meta.phishing_detected}"
  ]
}
