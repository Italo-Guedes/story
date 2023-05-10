# frozen_string_literal: true

redis_pool_size = ENV.fetch('REDIS_POOL_SIZE') { '12' }.to_i
redis_url = ENV.fetch('REDIS_URL') { 'redis://localhost:6379/0' }
Sidekiq.configure_server do |config|
  config.redis = { url: redis_url, size: redis_pool_size }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url, size: redis_pool_size }
end

require 'sidekiq/web'
Sidekiq::Web.set :sessions, false

Rails.application.reloader.to_prepare do
  sidekiq_cronfig = 'config/sidekiq_cron.yml'
  if Sidekiq.server? && File.exist?(sidekiq_cronfig) && (config = YAML.load_file(sidekiq_cronfig))
    Sidekiq::Cron::Job.load_from_hash config
  end
end
