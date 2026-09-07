resource "elasticstack_elasticsearch_security_api_key" "viewer" {
  name = "kampisos-vercel-production"

  role_descriptors = jsonencode({
    readonly = {
      indices = [
        {
          names      = ["kampisos-*"]
          privileges = ["read"]
        }
      ]
    }
  })
}

resource "elasticstack_elasticsearch_index" "entries" {
  name = "kampisos-entries"

  analysis_char_filter = jsonencode({
    # Removes all Japanese characters (Kanji and Kana) from Ainu texts
    # This is for handling the code switchings
    ainu_code_switching = {
      type        = "pattern_replace"
      pattern     = "[\\p{Script=Han}\\p{Script=Hiragana}\\p{Script=Katakana}]"
      replacement = ""
    }
    # Removes all Latin characters from Japanese texts
    # Opposite for `ainu_code_switching`
    japanese_code_switching = {
      type        = "pattern_replace"
      pattern     = "[\\p{Script=Latin}]"
      replacement = ""
    }
  })

  analysis_analyzer = jsonencode({
    ainu_standard = {
      tokenizer   = "standard"
      filter      = ["icu_normalizer", "cjk_width", "asciifolding", "lowercase"]
      char_filter = ["ainu_code_switching"]
    }
    ainu_ngram = {
      tokenizer   = "ngram"
      filter      = ["icu_normalizer", "cjk_width", "asciifolding", "lowercase"]
      char_filter = ["ainu_code_switching"]
    }
    # Standard kuromoji-analyzer without `kuromoji_part_of_speech` and `ja_stop`
    # c.f. https://www.elastic.co/docs/reference/elasticsearch/plugins/analysis-kuromoji-analyzer
    japanese = {
      tokenizer = "kuromoji_tokenizer",
      filter = [
        "kuromoji_baseform",
        "cjk_width",
        "kuromoji_stemmer",
        "lowercase"
      ]
      char_filter = [
        "japanese_code_switching"
      ]
    }
  })

  mappings = jsonencode({
    properties = {
      id                = { type = "keyword" }
      collection_lv1    = { type = "keyword" }
      collection_lv2    = { type = "keyword" }
      collection_lv3    = { type = "keyword" }
      document          = { type = "keyword" }
      uri               = { type = "keyword" }
      pronoun           = { type = "keyword" }
      author            = { type = "keyword" }
      dialect           = { type = "keyword" }
      dialect_lv1       = { type = "keyword" }
      dialect_lv2       = { type = "keyword" }
      dialect_lv3       = { type = "keyword" }
      recorded_at       = { type = "keyword" }
      published_at      = { type = "keyword" }
      recorded_by       = { type = "keyword" }
      translated_by     = { type = "keyword" }
      transliterated_by = { type = "keyword" }

      text = {
        type     = "text",
        analyzer = "ainu_standard",
        fields = {
          ngram = {
            type     = "text"
            analyzer = "ainu_ngram"
          }
        }
      }

      translations = {
        properties = {
          jpn = {
            type     = "text"
            analyzer = "japanese"
          }
        }
      }
    }
  })
}

