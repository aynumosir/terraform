terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 5.8.2"
    }

    vercel = {
      source  = "vercel/vercel"
      version = ">= 4.7.1"
    }

    elasticstack = {
      source  = "elastic/elasticstack"
      version = ">= 0.14.3"
    }

    github = {
      source  = "integrations/github"
      version = ">= 6.12.1"
    }
  }

  cloud {
    organization = "aynumosir"

    workspaces {
      name = "kampisos"
    }
  }
}

provider "elasticstack" {
  elasticsearch {}
}

provider "github" {
  owner = "aynumosir"
}

