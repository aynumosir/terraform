resource "vercel_project" "this" {
  name      = "mosem"
  framework = "nextjs"
  git_repository = {
    type = "github"
    repo = data.github_repository.this.full_name
  }
}

moved {
  from = vercel_project.mosem
  to   = vercel_project.this
}

resource "vercel_project_domain" "www_aynu_io" {
  project_id = vercel_project.this.id
  domain     = "www.aynu.io"
}

resource "vercel_project_domain" "aynu_io" {
  project_id = vercel_project.this.id
  domain     = "aynu.io"
  redirect   = "www.aynu.io"
}

