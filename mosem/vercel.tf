resource "vercel_project" "mosem" {
  name      = "mosem"
  framework = "nextjs"
  git_repository = {
    type = "github"
    repo = data.github_repository.this.full_name
  }
}

resource "vercel_project_domain" "www_aynu_io" {
  project_id = vercel_project.mosem.id
  domain     = "www.aynu.io"
}

resource "vercel_project_domain" "aynu_io" {
  project_id = vercel_project.mosem.id
  domain     = "aynu.io"
  redirect   = "www.aynu.io"
}

