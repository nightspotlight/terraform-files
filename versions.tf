terraform {
  required_version = ">= 0.14"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.21"
    }
    #hcloud = {
    #  source  = "hetznercloud/hcloud"
    #  version = "~> 1.35"
    #}
    #cloudinit = {
    #  source  = "hashicorp/cloudinit"
    #  version = "~> 2.2"
    #}
  }
}
