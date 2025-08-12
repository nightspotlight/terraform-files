module "dns" {
  source = "./modules/cloudflare-dns"

  zone_id = cloudflare_zone.nightspotlight_me.id

  a_records     = merge(local.nextcloud_a_record, var.a_records)
  aaaa_records  = merge(local.nextcloud_aaaa_record, var.aaaa_records)
  cname_records = var.cname_records
  mx_records    = var.mx_records
  txt_records   = var.txt_records
}
