provider "hcloud" {
  token = var.hcloud_token
}

locals {
  any_network = ["0.0.0.0/0", "::/0"]
  tags = merge(
    {
      "terraform" = "true"
      "app"       = "nextcloud"
    },
    var.additional_tags
  )
}

moved {
  from = hcloud_ssh_key.roman
  to   = hcloud_ssh_key.nextcloud
}

resource "hcloud_ssh_key" "nextcloud" {
  name = local.tags.app

  public_key = file("${path.root}/files/ssh/roman.key.pub")

  labels = local.tags
}

resource "hcloud_server" "nextcloud" {
  name = local.tags.app

  server_type  = "cx21"
  location     = "nbg1"
  image        = "debian-10"
  ssh_keys     = [hcloud_ssh_key.nextcloud.id]
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
  name = "${local.tags.app}-data"

  server_id = hcloud_server.nextcloud.id
  size      = 150 # GB
  format    = "xfs"
  automount = true

  delete_protection = true

  labels = local.tags
}

resource "hcloud_firewall" "nextcloud" {
  name = local.tags.app

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
