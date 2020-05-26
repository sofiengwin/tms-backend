SIDEKIQ_REDIS_URL = Rails.env.test? ? ENV['TEST_SIDEKIQ_REDIS_URL'] : ENV['REDIS_URL']

sidekiq_redis = { url: SIDEKIQ_REDIS_URL }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_redis
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_redis
end