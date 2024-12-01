module "dns" {
  source = "./modules/cloudflare-dns"

  zone_id = cloudflare_zone.nightspotlight_me.id

  a_records     = local.nextcloud_a_record
  aaaa_records  = local.nextcloud_aaaa_record
  cname_records = var.cname_records
  mx_records    = var.mx_records
  txt_records   = var.txt_records
}
