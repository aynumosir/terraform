# terraform

Terraform configuration for [aynu.io](https://aynu.io) infrastructure.

## Workspaces

| Workspace | Domain |
|-----------|--------|
| [mosem](./mosem) | aynu.io, www.aynu.io |
| [kampisos](./kampisos) | kampisos.aynu.io |
| [tunci](./tunci) | tunci.aynu.io |

## Stack

- **DNS**: Cloudflare
- **Hosting**: Vercel
- **State**: Terraform Cloud (`aynumosir` organization)

## Usage

Runs are triggered automatically via Terraform Cloud's VCS-driven workflow on push to `main`.
