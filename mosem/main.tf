terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = ">= 5.8.2"
    }

    vercel = {
      source = "vercel/vercel"
      version = "~> 0.3"
    }
  }

  backend "remote" {
    hostname = "app.terraform.io"
    organization = "aynumosir"

    workspaces {
      name = "mosem"
    }
  }
}

resource "cloudflare_dns_record" "aynu_io" {
  zone_id = "${var.cloudflare_zone_id}"
  name    = "aynu.io"
  content = "216.198.79.1"
  type    = "A"
  ttl     = 1
  proxied = false 
}

resource "cloudflare_dns_record" "www_aynu_io" {
  zone_id = "${var.cloudflare_zone_id}"
  name    = "www"
  content = "96811a0b124c3be5.vercel-dns-017.com"
  type    = "CNAME"
  ttl     = 1
  proxied = false 
}

resource "vercel_project" "mosem" {
  name      = "mosem"
  framework = "nextjs"
  git_repository = {
    type = "github"
    repo = "aynumosir/mosem"
  }
}

resource "vercel_project_domain" "www_aynu_io" {
  project_id = vercel_project.mosem.id
  domain     = "www.aynu.io"
}

resource "vercel_project_domain" "aynu_io" {
  project_id = vercel_project.mosem.id
  domain     = "aynu.io"
  redirect   = "www.aynu.io"
}

