variable "cloudflare_zone_id" {
  type        = string
  description = "CloudflareのZone ID（ドメインに対して割り当てられているID）"
}

variable "hf_mt_endpoint" {
  type        = string
  description = "機械翻訳につかうHugging Face Inference EndpointのURL"
}

variable "hf_kana_endpoint" {
  type        = string
  description = "カナ変換につかうHugging Face Inference EndpointのURL"
}

variable "hf_token" {
  type        = string
  description = "Hugging Face HubのAPIトークン"
}

