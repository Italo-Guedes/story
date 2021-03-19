# frozen_string_literal: true

Rails.application.routes.draw do
  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  authenticate :user, -> (u) { u.has_role?(:super_admin) } do
    require 'sidekiq/web'
    require 'sidekiq/cron/web'
    Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]
    mount Sidekiq::Web => '/sidekiq'
    
    mount PgHero::Engine, at: 'pghero'
  end

  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do

    get 'versions/:model_name', to: 'versions#index', as: 'index_versions'
    get 'versions/:model_name/:id', to: 'versions#show', as: 'show_version'

    concern :commenteable do
      resources :comments, only: %i[index create destroy]
    end

    # Exemplo de como habilitar rotas de comentários em um resource
    # resources :nome, concerns: :commenteable

    # devise_for :users, skip: [:registrations], controllers: { confirmations: 'users/confirmations' }
    # as :user do
      # get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
      # put 'users' => 'devise/registrations#update', :as => 'user_registration'
    # end

    devise_for :users, controllers: { confirmations: 'users/confirmations' }

    get 'home/index'
    get 'home/calendar'
    get 'home/calendar_events'
    get 'home/contact'
    get 'home/about'
    get 'home/set_locale'
    get 'admin_pages/database_changes'
    get 'admin_pages/sidekiq'
    get 'admin_pages/pghero'
    # get 'site', to: 'statics#index'

    resources :global_settings, only: %i[index edit update]
    resources :users, path: '/admin/users', concerns: :commenteable
    resources :notifications, only: [:index] do
      member do
        post 'mark_read'
      end
      collection do
        post 'mark_all_read'
      end
    end
    root to: 'home#index'
  end

  get 'site', to: 'statics#index', as: 'site'
  get 'site/*other', to: 'statics#index'

  get 'public', to: 'statics#public', as: 'public'
  get 'public/*other', to: 'statics#public'


  get '/:locale' => 'home#index', locale: /#{I18n.available_locales.join('|')}/
end
