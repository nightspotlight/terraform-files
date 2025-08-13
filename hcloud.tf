#locals {
#  nextcloud_a_record = {
#    lookup(hcloud_server.nextcloud.labels, "dns_subdomain", "nextcloud") = {
#      address = hcloud_primary_ip.nextcloud_ipv4.ip_address,
#      proxied = lookup(hcloud_server.nextcloud.labels, "cf_proxied", "false")
#    }
#  }
#  nextcloud_aaaa_record = {
#    lookup(hcloud_server.nextcloud.labels, "dns_subdomain", "nextcloud") = {
#      address = cidrhost("${hcloud_primary_ip.nextcloud_ipv6.ip_address}/64", 1),
#      proxied = lookup(hcloud_server.nextcloud.labels, "cf_proxied", "false")
#    }
#  }
#  any_network = ["0.0.0.0/0", "::/0"]
#  tags = merge(
#    {
#      "terraform" = "true"
#      "app"       = "nextcloud"
#    },
#    var.additional_tags
#  )
#}

#resource "hcloud_ssh_key" "nextcloud" {
#  name = local.tags.app
#
#  public_key = file("${path.root}/files/ssh/roman.key.pub")
#
#  labels = local.tags
#}

#resource "hcloud_primary_ip" "nextcloud_ipv4" {
#  name = "${local.tags.app}-ipv4"
#
#  type              = "ipv4"
#  assignee_type     = "server"
#  assignee_id       = hcloud_server.nextcloud.id
#  auto_delete       = false
#  delete_protection = true
#
#  labels = local.tags
#}

#resource "hcloud_primary_ip" "nextcloud_ipv6" {
#  name = "${local.tags.app}-ipv6"
#
#  type              = "ipv6"
#  assignee_type     = "server"
#  assignee_id       = hcloud_server.nextcloud.id
#  auto_delete       = false
#  delete_protection = true
#
#  labels = local.tags
#}

#resource "hcloud_server" "nextcloud" {
#  name = local.tags.app
#
#  server_type  = "cpx11"
#  location     = "nbg1"
#  image        = "debian-10"
#  ssh_keys     = [hcloud_ssh_key.nextcloud.id]
#  user_data    = data.cloudinit_config.user-data.rendered
#  firewall_ids = [hcloud_firewall.nextcloud.id]
#
#  keep_disk          = true
#  delete_protection  = true
#  rebuild_protection = true
#
#  public_net {
#    ipv4_enabled = true
#    ipv6_enabled = true
#  }
#
#  labels = merge(local.tags,
#    {
#      "docker"        = "true",
#      "dns_subdomain" = "share",
#      "cf_proxied"    = "false"
#    }
#  )
#
#  lifecycle {
#    ignore_changes = [
#      ssh_keys,
#      user_data
#    ]
#  }
#}

#resource "hcloud_volume" "nextcloud-data" {
#  name = "${local.tags.app}-data"
#
#  server_id = hcloud_server.nextcloud.id
#  size      = 150 # GB
#  format    = "xfs"
#  automount = true
#
#  delete_protection = true
#
#  labels = local.tags
#}

#resource "hcloud_firewall" "nextcloud" {
#  name = local.tags.app
#
#  rule {
#    direction  = "in"
#    protocol   = "icmp"
#    source_ips = local.any_network
#  }
#
#  rule {
#    direction  = "in"
#    protocol   = "tcp"
#    port       = "22"
#    source_ips = local.any_network
#  }
#
#  rule {
#    direction  = "in"
#    protocol   = "tcp"
#    port       = "80"
#    source_ips = local.any_network
#  }
#
#  rule {
#    direction  = "in"
#    protocol   = "tcp"
#    port       = "443"
#    source_ips = local.any_network
#  }
#
#  labels = local.tags
#}
