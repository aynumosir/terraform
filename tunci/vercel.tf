resource "vercel_project" "this" {
  name      = "tunci"
  framework = "nextjs"

  git_repository = {
    type = "github"
    repo = data.github_repository.this.full_name
  }
}

resource "vercel_project_domain" "this" {
  project_id = vercel_project.this.id
  domain     = "tunci.aynu.io"
}

moved {
  from = vercel_project.tunci
  to   = vercel_project.this
}

moved {
  from = vercel_project_domain.tunci_aynu_io
  to   = vercel_project_domain.this
}

resource "vercel_project_environment_variable" "hf_mt_endpoint" {
  project_id = vercel_project.this.id
  key        = "HF_MT_ENDPOINT"
  value      = var.hf_mt_endpoint
  target     = ["production", "preview", "development"]
  sensitive  = false
}

resource "vercel_project_environment_variable" "hf_kana_endpoint" {
  project_id = vercel_project.this.id
  key        = "HF_KANA_ENDPOINT"
  value      = var.hf_kana_endpoint
  target     = ["production", "preview", "development"]
  sensitive  = false
}

resource "vercel_project_environment_variable" "hf_token" {
  project_id = vercel_project.this.id
  key        = "HF_TOKEN"
  value      = var.hf_token
  target     = ["production", "preview"]
  sensitive  = true
}

