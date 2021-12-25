terraform {
  required_version = ">= 0.13"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.6"
    }
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.32"
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
  api_token = var.cloudflare_api_token
}

provider "hcloud" {
  token = var.hcloud_token
}
