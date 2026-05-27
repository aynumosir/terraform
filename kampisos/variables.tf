variable "domain" {
  type        = string
  description = "公開するURL"
}

variable "elasticsearch_endpoints" {
  type        = list(string)
  description = "ElasticsearchインスタンスのURL"
}

variable "microcms_service_domain" {
  type        = string
  description = "更新履歴に使うMicroCMSのサービスドメイン"
}

variable "microcms_api_key" {
  type        = string
  description = "更新履歴に使うMicroCMSのAPIキー"
}

variable "cloudflare_zone_id" {
  type        = string
  description = "CloudflareのZone ID（ドメインに対して割り当てられているID）"
}
