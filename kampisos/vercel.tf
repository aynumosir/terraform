data "github_repository" "this" {
  full_name = "aynumosir/kampisos"
}

resource "cloudflare_dns_record" "this" {
  zone_id = var.cloudflare_zone_id
  name    = "kampisos"
  content = "8b00208f3a81a61c.vercel-dns-017.com"
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

resource "vercel_project" "this" {
  name      = "kampisos"
  framework = "nextjs"
  git_repository = {
    type = "github"
    repo = data.github_repository.this.full_name
  }
}

resource "vercel_project_domain" "this" {
  project_id = vercel_project.this.id
  domain     = var.domain
}

resource "vercel_project_environment_variables" "this" {
  project_id = vercel_project.this.id
  variables = [
    {
      key       = "MICROCMS_SERVICE_DOMAIN"
      value     = var.microcms_service_domain
      sensitive = false
      target    = ["production", "preview", "development"]
    },
    {
      key       = "MICROCMS_API_KEY"
      value     = var.microcms_api_key
      sensitive = true
      target    = ["production", "preview"]
    },

    {
      key       = "ELASTICSEARCH_ENDPOINTS"
      value     = join(" ", var.elasticsearch_endpoints)
      sensitive = false
      target    = ["production", "preview"]
    },
    {
      key       = "ELASTICSEARCH_API_KEY"
      value     = elasticstack_elasticsearch_security_api_key.viewer.encoded
      sensitive = true
      target    = ["production", "preview"]
    },
  ]
}

resource "github_actions_secret" "elasticsearch_api_key" {
  repository  = data.github_repository.this.name
  secret_name = "ELASTICSEARCH_API_KEY"
  value       = elasticstack_elasticsearch_security_api_key.viewer.encoded
}

resource "github_actions_secret" "elasticsearch_endpoints" {
  repository  = data.github_repository.this.name
  secret_name = "ELASTICSEARCH_ENDPOINTS"
  value       = join(" ", var.elasticsearch_endpoints)
}

moved {
  from = cloudflare_dns_record.kampisos_aynu_io
  to   = cloudflare_dns_record.this
}

moved {
  from = vercel_project.kampisos
  to   = vercel_project.this
}

moved {
  from = vercel_project_domain.kampisos_aynu_io
  to   = vercel_project_domain.this
}

moved {
  from = vercel_project_environment_variables.kampisos
  to   = vercel_project_environment_variables.this
}

moved {
  from = github_actions_secret.kampisos_elasticsearch_api_key
  to   = github_actions_secret.elasticsearch_api_key
}

moved {
  from = github_actions_secret.kampisos_elasticsearch_endpoints
  to   = github_actions_secret.elasticsearch_endpoints
}
