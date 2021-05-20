resource "hcloud_ssh_key" "roman" {
  name       = "roman"
  public_key = file("${path.root}/files/ssh/roman.key.pub")
}

resource "hcloud_server" "nextcloud" {
  name        = "nextcloud"
  server_type = "cx21-ceph"
  location    = "nbg1"
  image       = "debian-10"
  keep_disk   = true
  ssh_keys    = [hcloud_ssh_key.roman.id]
  user_data   = file("${path.root}/files/cloud-init/user-data.yml")
}
