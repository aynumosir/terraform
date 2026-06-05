resource "vercel_project" "tunci" {
  name      = "tunci"
  framework = "nextjs"

  git_repository = {
    type = "github"
    repo = data.github_repository.this.full_name
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
      key       = "HF_MT_ENDPOINT"
      value     = var.hf_mt_endpoint
      target    = ["production", "preview", "development"]
      sensitive = false
    },
    {
      key       = "HF_KANA_ENDPOINT"
      value     = var.hf_kana_endpoint
      target    = ["production", "preview", "development"]
      sensitive = false
    },
    {
      key       = "HF_TOKEN",
      value     = var.hf_token
      target    = ["production", "preview"]
      sensitive = true
    }
  ]
}

