# frozen_string_literal: true

# config/routes/admin.rb
authenticate :user, ->(u) { u.has_role?(:super_admin) } do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]
  mount Sidekiq::Web => '/sidekiq'
  mount PgHero::Engine, at: 'pghero'
end

get 'admin_pages/database_changes'
get 'admin_pages/sidekiq'
get 'admin_pages/pghero'
