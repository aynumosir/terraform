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

