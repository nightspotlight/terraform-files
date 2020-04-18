terraform {
  required_version = "~> 0.12"
  required_providers {
    cloudflare = "~> 2.1"
    hcloud = "~> 1.12"
  }
}

provider "cloudflare" {
  email = var.cloudflare_email
  account_id = var.cloudflare_account_id
  api_key = var.cloudflare_api_key
}

provider "hcloud" {
  token = var.hcloud_token
}
