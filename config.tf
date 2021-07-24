terraform {
  required_version = ">= 0.13"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.24"
    }
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.27"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.2"
    }
  }

  backend "remote" {
    organization = "nightspotlight"

    workspaces {
      name = "terraform-files"
    }
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
