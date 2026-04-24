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

    elasticstack = {
      source = "elastic/elasticstack"
      version = ">= 0.14.3" 
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

provider "elasticstack" {
  elasticsearch {}
}

resource "elasticstack_elasticsearch_security_api_key" "vercel" {
  name = "kampisos-vercel-production"

  role_descriptors = jsonencode({
    readonly = {
      indices = [{
        names      = ["kampisos-*"]
        privileges = ["read"]
      }]
    }
  })
}

resource "elasticstack_elasticsearch_index" "entries" {
  name = "kampisos-entries"

  analysis_analyzer = jsonencode({
    japanese = {
      type = "kuromoji"
      mode = "search"
    }

    # https://www.elastic.co/docs/reference/text-analysis/analysis-ngram-tokenizer
    ainu = {
      tokenizer = "ngram"
    }
  })

  mappings = jsonencode({
    properties = {
      id = { type = "keyword" }
      collection_lv1 = { type = "keyword" }
      collection_lv2 = { type = "keyword" }
      collection_lv3 = { type = "keyword" }
      document = { type = "keyword" }
      uri = { type = "keyword" }
      pronoun = { type = "keyword" }
      author = { type = "keyword" }
      dialect = { type = "keyword" }
      dialect_lv1 = { type = "keyword" }
      dialect_lv2 = { type = "keyword" }
      dialect_lv3 = { type = "keyword" }
      text = { type = "text", analyzer = "ainu" }
      translation = { type = "text", analyzer = "japanese" }
      recorded_at = { type = "keyword" }
      published_at = { type = "keyword" }
    }
  })
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

resource "vercel_project_environment_variables" "kampisos" {
  project_id = vercel_project.kampisos.id
  variables = [
    {
      key    = "ALGOLIA_APP_ID"
      value  = var.algolia_app_id
      target = ["production", "preview", "development"]
    },
    {
      key       = "ALGOLIA_API_KEY"
      value     = var.algolia_api_key
      sensitive = true
      target    = ["production", "preview"]
    },
    {
      key    = "MICROCMS_SERVICE_DOMAIN"
      value  = var.microcms_service_domain
      target = ["production", "preview", "development"]
    },
    {
      key       = "MICROCMS_API_KEY"
      value     = var.microcms_api_key
      sensitive = true
      target    = ["production", "preview"]
    },
    {
      key       = "ELASTICSEARCH_API_KEY"
      value     = elasticstack_elasticsearch_security_api_key.vercel.encoded
      sensitive = true
      target    = ["production", "preview"]
    },
  ]
}
