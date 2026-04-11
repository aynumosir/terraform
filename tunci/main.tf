terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = ">= 5.8.2"
    }

    vercel = {
      source = "vercel/vercel"
      version = ">= 4.7.1"
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

resource "vercel_project_environment_variables" "tunci" {
  project_id = vercel_project.tunci.id
  variables = [
    {
      key    = "ALGOLIA_APP_ID"
      value  = var.algolia_app_id
      target = ["production", "preview", "development"]
    },
    {
      key       = "ALGOLIA_API_KEY"
      value     = var.algolia_api_key
      target    = ["production", "preview", "development"]
      sensitive = true
    },
    {
      key    = "HF_MT_ENDPOINT"
      value  = var.hf_mt_endpoint
      target = ["production", "preview", "development"]
    },
    {
      key    = "HF_KANA_ENDPOINT"
      value  = var.hf_kana_endpoint
      target = ["production", "preview", "development"]
    },
    {
      key       = "HF_TOKEN",
      value     = var.hf_token
      target    = ["production", "preview", "development"]
      sensitive = true
    }
  ]
}
