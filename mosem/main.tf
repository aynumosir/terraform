terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 5.8.2"
    }

    vercel = {
      source  = "vercel/vercel"
      version = "~> 0.3"
    }

    github = {
      source  = "integrations/github"
      version = ">= 6.12.1"
    }
  }

  cloud {
    organization = "aynumosir"

    workspaces {
      name = "mosem"
    }
  }
}

