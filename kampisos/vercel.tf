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
  domain     = "kampisos.aynu.io"
}

resource "vercel_project_environment_variable" "microcms_service_domain" {
  project_id = vercel_project.this.id
  key        = "MICROCMS_SERVICE_DOMAIN"
  value      = var.microcms_service_domain
  sensitive  = false
  target     = ["production", "preview", "development"]
}

resource "vercel_project_environment_variable" "microcms_api_key" {
  project_id = vercel_project.this.id
  key        = "MICROCMS_API_KEY"
  value_wo   = var.microcms_api_key
  sensitive  = true
  target     = ["production", "preview"]
}

resource "vercel_project_environment_variable" "elasticsearch_endpoints" {
  project_id = vercel_project.this.id
  key        = "ELASTICSEARCH_ENDPOINTS"
  value      = join(" ", var.elasticsearch_endpoints)
  sensitive  = false
  target     = ["production", "preview"]
}

resource "vercel_project_environment_variable" "elasticsearch_api_key" {
  project_id = vercel_project.this.id
  key        = "ELASTICSEARCH_API_KEY"
  value_wo   = elasticstack_elasticsearch_security_api_key.viewer.encoded
  sensitive  = true
  target     = ["production", "preview"]
}

