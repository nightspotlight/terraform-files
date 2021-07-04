locals {
  any_network = ["0.0.0.0/0", "::/0"]
}

resource "hcloud_ssh_key" "roman" {
  name       = "Roman@Roman-PC"
  public_key = file("${path.root}/files/ssh/roman.key.pub")

  labels = {
    managed_by_terraform = "true"
  }
}

resource "hcloud_server" "nextcloud" {
  name         = "nextcloud"
  server_type  = "cx21-ceph"
  location     = "nbg1"
  image        = "debian-10"
  keep_disk    = true
  ssh_keys     = [hcloud_ssh_key.roman.id]
  user_data    = file("${path.root}/files/cloud-init/user-data.yml")
  firewall_ids = [hcloud_firewall.nextcloud.id]

  labels = {
    app                  = "nextcloud",
    docker               = "true",
    managed_by_terraform = "true",
    dns_subdomain        = "share",
    cf_proxied           = "false"
  }

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

  labels = {
    app                  = "nextcloud",
    managed_by_terraform = "true"
  }
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

  labels = {
    app                  = "nextcloud",
    managed_by_terraform = "true"
  }
}
