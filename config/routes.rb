# frozen_string_literal: true

# == Route Map
#
#                   Prefix Verb   URI Pattern                                         Controller#Action
#                                 /cable                                              #<ActionCable::Server::Base:0x00000006979720 @mutex=#<Monitor:0x000000069796d0 @mon_owner=nil, @mon_count=0, @mon_mutex=#<Thread::Mutex:0x00000006979680>>, @pubsub=nil, @worker_pool=nil, @event_loop=nil, @remote_connections=nil>
#         new_user_session GET    (/:locale)/users/sign_in(.:format)                  devise/sessions#new {:locale=>/pt-BR/}
#             user_session POST   (/:locale)/users/sign_in(.:format)                  devise/sessions#create {:locale=>/pt-BR/}
#     destroy_user_session DELETE (/:locale)/users/sign_out(.:format)                 devise/sessions#destroy {:locale=>/pt-BR/}
#   edit_user_registration GET    (/:locale)/users/edit(.:format)                     devise/registrations#edit {:locale=>/pt-BR/}
#        user_registration PUT    (/:locale)/users(.:format)                          devise/registrations#update {:locale=>/pt-BR/}
#               home_index GET    (/:locale)/home/index(.:format)                     home#index {:locale=>/pt-BR/}
#             home_contact GET    (/:locale)/home/contact(.:format)                   home#contact {:locale=>/pt-BR/}
#               home_about GET    (/:locale)/home/about(.:format)                     home#about {:locale=>/pt-BR/}
#    home_database_changes GET    (/:locale)/home/database_changes(.:format)          home#database_changes {:locale=>/pt-BR/}
# more_notifications_users GET    (/:locale)/admin/users/more_notifications(.:format) users#more_notifications {:locale=>/pt-BR/}
#                    users GET    (/:locale)/admin/users(.:format)                    users#index {:locale=>/pt-BR/}
#                          POST   (/:locale)/admin/users(.:format)                    users#create {:locale=>/pt-BR/}
#                 new_user GET    (/:locale)/admin/users/new(.:format)                users#new {:locale=>/pt-BR/}
#                edit_user GET    (/:locale)/admin/users/:id/edit(.:format)           users#edit {:locale=>/pt-BR/}
#                     user GET    (/:locale)/admin/users/:id(.:format)                users#show {:locale=>/pt-BR/}
#                          PATCH  (/:locale)/admin/users/:id(.:format)                users#update {:locale=>/pt-BR/}
#                          PUT    (/:locale)/admin/users/:id(.:format)                users#update {:locale=>/pt-BR/}
#                          DELETE (/:locale)/admin/users/:id(.:format)                users#destroy {:locale=>/pt-BR/}
#                     root GET    /                                                   home#index
#                          GET    /:locale(.:format)                                  home#index {:locale=>/pt-BR/}
# 

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
