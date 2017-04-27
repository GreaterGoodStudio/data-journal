Rails.application.config.cache_store = :redis_store, Rails.application.secrets.redis_url, { expires_in: 90.minutes, namespace: "cache" }
