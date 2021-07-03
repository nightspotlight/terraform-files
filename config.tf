terraform {
  required_version = ">= 0.13"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.22"
    }
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.27"
    }
    # hetznerdns = {
    #   source  = "timohirt/hetznerdns"
    #   version = "1.1.1"
    # }
  }
}

provider "cloudflare" {
  email      = var.cloudflare_email
  account_id = var.cloudflare_account_id
  api_key    = var.cloudflare_api_key
}

provider "hcloud" {
  token = var.hcloud_token
}

# provider "hetznerdns" {
#   apitoken = var.hetznerdns_token
# }
