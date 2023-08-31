# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rdmapps
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.time_zone = 'Brasilia'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'pt-BR'
    config.i18n.fallbacks = true

    # rails will fallback to en, no matter what is set as config.i18n.default_locale
    config.i18n.fallbacks = %w[pt-BR]
    config.i18n.available_locales = %w[pt-BR en]

    # Disable default test files
    config.generators.system_tests = nil

    # Generate Rspec test files
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: false,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false
    end

    config.action_controller.default_protect_from_forgery = false

    # Descomentar se for utilizar o sidekiq
    config.active_job.queue_adapter = :sidekiq

    # Descomentar para desabilitar o rack-attack (é ativo por padrão)
    # Rack::Attack.enabled = false

    # # Configuração do Sentry
    # Raven.configure do |config|
    #   # Gerar o dsn no Sentry
    #   config.dsn = ''
    #   config.environments = %w[production staging]
    #   # config.excluded_exceptions += ['Errno::ENOENT']

    #   # Descomentar se tiver o sidekiq
    #   config.async = lambda { |event|
    #     SentryJob.perform_later(event)
    #   }
    # end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
