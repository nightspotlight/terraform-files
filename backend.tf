terraform {
  cloud {
    organization = "nightspotlight"

    workspaces {
      name = "terraform-files"
    }
  }
}
