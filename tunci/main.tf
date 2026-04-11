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
      name = "tunci"
    }
  }
}

import {
  to = cloudflare_dns_record.tunci_aynu_io
  id = "7b42f86a86701ddbccaac476cabfa6fa/56159609aa9386c6726a7f94a7d02dca"
}

import {
  to = vercel_project.tunci
  id = "prj_98xNr72TyzlxWIsUCTYlj0HZQzTP"
}

import {
  to = vercel_project_domain.tunci_aynu_io
  id = "prj_98xNr72TyzlxWIsUCTYlj0HZQzTP/tunci.aynu.io"
}

resource "cloudflare_dns_record" "tunci_aynu_io" {
  zone_id = "${var.cloudflare_zone_id}"
  name    = "tunci"
  content = "23438773b0f10f29.vercel-dns-017.com"
  type    = "CNAME"
  ttl     = 1
  proxied = false 
}

resource "vercel_project" "tunci" {
  name      = "tunci"
  framework = "nextjs"
  git_repository = {
    type = "github"
    repo = "aynumosir/tunci"
  }
}

resource "vercel_project_domain" "tunci_aynu_io" {
  project_id = vercel_project.tunci.id
  domain     = "tunci.aynu.io"
}
