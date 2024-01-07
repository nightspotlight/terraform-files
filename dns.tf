module "dns" {
  source = "./modules/cloudflare-dns"

  zone_id = cloudflare_zone.nightspotlight_me.id

  a_records    = local.nextcloud_a_record
  aaaa_records = local.nextcloud_aaaa_record
  txt_records = {
    "nightspotlight.me" = "v=spf1 -all",
    "*._domainkey"      = "v=DKIM1; p=",
    "_dmarc"            = "v=DMARC1; p=reject; sp=reject; adkim=s; aspf=s;"
  }
}
