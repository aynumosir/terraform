resource "cloudflare_dns_record" "this" {
  zone_id = var.cloudflare_zone_id
  name    = "kampisos"
  content = "8b00208f3a81a61c.vercel-dns-017.com"
  type    = "CNAME"
  ttl     = 1
  proxied = false
}
