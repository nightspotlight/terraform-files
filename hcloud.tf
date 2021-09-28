locals {
  any_network = ["0.0.0.0/0", "::/0"]
  tags = merge(
    {
      "app" = "nextcloud"
    },
    var.common_tags
  )
}

resource "hcloud_ssh_key" "roman" {
  name       = "Roman@Roman-PC"
  public_key = file("${path.root}/files/ssh/roman.key.pub")

  labels = var.common_tags
}

resource "hcloud_server" "nextcloud" {
  name         = "nextcloud"
  server_type  = "cx21-ceph"
  location     = "nbg1"
  image        = "debian-10"
  ssh_keys     = [hcloud_ssh_key.roman.id]
  user_data    = data.cloudinit_config.user-data.rendered
  firewall_ids = [hcloud_firewall.nextcloud.id]

  keep_disk          = true
  delete_protection  = true
  rebuild_protection = true

  labels = merge(
    {
      "docker"        = "true",
      "dns_subdomain" = "share",
      "cf_proxied"    = "false"
    },
    local.tags
  )

  lifecycle {
    ignore_changes = [
      ssh_keys,
      user_data
    ]
  }
}

resource "hcloud_volume" "nextcloud-data" {
  name      = "nextcloud-data"
  size      = 115 # GB
  server_id = hcloud_server.nextcloud.id
  automount = true
  format    = "xfs"

  delete_protection = true

  labels = local.tags
}

resource "hcloud_firewall" "nextcloud" {
  name = "nextcloud"

  rule {
    direction  = "in"
    protocol   = "icmp"
    source_ips = local.any_network
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = local.any_network
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "80"
    source_ips = local.any_network
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "443"
    source_ips = local.any_network
  }

  labels = local.tags
}
