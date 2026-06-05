resource "cloudflare_dns_record" "aynu_io" {
  zone_id = var.cloudflare_zone_id
  name    = "aynu.io"
  content = "216.198.79.1"
  type    = "A"
  ttl     = 1
  proxied = false
}

resource "cloudflare_dns_record" "www_aynu_io" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  content = "96811a0b124c3be5.vercel-dns-017.com"
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

