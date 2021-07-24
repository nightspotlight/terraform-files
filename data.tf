data "cloudinit_config" "user-data" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "user-data.cfg"
    content_type = "text/cloud-config"
    content      = <<-EOF
      #cloud-config
      package_update: true
      package_upgrade: true
      package_reboot_if_required: true
      packages:
        - bash
        - bash-completion
        - nano
        - curl
        - wget
        - ca-certificates
        - screen
        - zip
        - unzip
        - htop
        - iotop
        - iftop
        - rsync
        - needrestart
      EOF
  }
}
