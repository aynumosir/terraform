resource "cloudflare_dns_record" "this" {
  zone_id = var.cloudflare_zone_id
  name    = "tunci"
  content = "23438773b0f10f29.vercel-dns-017.com"
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

moved {
  from = cloudflare_dns_record.tunci_aynu_io
  to   = cloudflare_dns_record.this
}
