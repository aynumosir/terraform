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
      name = "kampisos"
    }
  }
}

import {
  to = cloudflare_dns_record.kampisos_aynu_io
  id = "7b42f86a86701ddbccaac476cabfa6fa/c0b07077e5b94e2f469cca09f7734d92"
}

import {
  to = vercel_project.kampisos
  id = "prj_vkC3QyumHZqksI5LUH2xjDSNSvFk"
}

import {
  to = vercel_project_domain.kampisos_aynu_io
  id = "prj_vkC3QyumHZqksI5LUH2xjDSNSvFk/kampisos.aynu.io"
}

resource "cloudflare_dns_record" "kampisos_aynu_io" {
  zone_id = "${var.cloudflare_zone_id}"
  name    = "kampisos"
  content = "8b00208f3a81a61c.vercel-dns-017.com"
  type    = "CNAME"
  ttl     = 1
  proxied = false 
}

resource "vercel_project" "kampisos" {
  name      = "kampisos"
  framework = "nextjs"
  git_repository = {
    type = "github"
    repo = "aynumosir/kampisos"
  }
}

resource "vercel_project_domain" "kampisos_aynu_io" {
  project_id = vercel_project.kampisos.id
  domain     = "kampisos.aynu.io"
}

