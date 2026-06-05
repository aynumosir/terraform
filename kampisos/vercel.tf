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

