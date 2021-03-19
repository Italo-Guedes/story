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

# == Route Map
#
# DEPRECATION WARNING: Using `bin/rake routes` is deprecated and will be removed in Rails 6.1. Use `bin/rails routes` instead.
#  (called from load at /usr/local/bundle/gems/ruby/2.7.0/bin/rake:23)
#                                Prefix Verb   URI Pattern                                                                              Controller#Action
#                           sidekiq_web        /sidekiq                                                                                 Sidekiq::Web
#                               pg_hero        /pghero                                                                                  PgHero::Engine
#                        index_versions GET    (/:locale)/versions/:model_name(.:format)                                                versions#index {:locale=>/pt-BR|en/}
#                          show_version GET    (/:locale)/versions/:model_name/:id(.:format)                                            versions#show {:locale=>/pt-BR|en/}
#                      new_user_session GET    (/:locale)/users/sign_in(.:format)                                                       devise/sessions#new {:locale=>/pt-BR|en/}
#                          user_session POST   (/:locale)/users/sign_in(.:format)                                                       devise/sessions#create {:locale=>/pt-BR|en/}
#                  destroy_user_session DELETE (/:locale)/users/sign_out(.:format)                                                      devise/sessions#destroy {:locale=>/pt-BR|en/}
#                     new_user_password GET    (/:locale)/users/password/new(.:format)                                                  devise/passwords#new {:locale=>/pt-BR|en/}
#                    edit_user_password GET    (/:locale)/users/password/edit(.:format)                                                 devise/passwords#edit {:locale=>/pt-BR|en/}
#                         user_password PATCH  (/:locale)/users/password(.:format)                                                      devise/passwords#update {:locale=>/pt-BR|en/}
#                                       PUT    (/:locale)/users/password(.:format)                                                      devise/passwords#update {:locale=>/pt-BR|en/}
#                                       POST   (/:locale)/users/password(.:format)                                                      devise/passwords#create {:locale=>/pt-BR|en/}
#              cancel_user_registration GET    (/:locale)/users/cancel(.:format)                                                        devise/registrations#cancel {:locale=>/pt-BR|en/}
#                 new_user_registration GET    (/:locale)/users/sign_up(.:format)                                                       devise/registrations#new {:locale=>/pt-BR|en/}
#                edit_user_registration GET    (/:locale)/users/edit(.:format)                                                          devise/registrations#edit {:locale=>/pt-BR|en/}
#                     user_registration PATCH  (/:locale)/users(.:format)                                                               devise/registrations#update {:locale=>/pt-BR|en/}
#                                       PUT    (/:locale)/users(.:format)                                                               devise/registrations#update {:locale=>/pt-BR|en/}
#                                       DELETE (/:locale)/users(.:format)                                                               devise/registrations#destroy {:locale=>/pt-BR|en/}
#                                       POST   (/:locale)/users(.:format)                                                               devise/registrations#create {:locale=>/pt-BR|en/}
#                 new_user_confirmation GET    (/:locale)/users/confirmation/new(.:format)                                              users/confirmations#new {:locale=>/pt-BR|en/}
#                     user_confirmation GET    (/:locale)/users/confirmation(.:format)                                                  users/confirmations#show {:locale=>/pt-BR|en/}
#                                       POST   (/:locale)/users/confirmation(.:format)                                                  users/confirmations#create {:locale=>/pt-BR|en/}
#                            home_index GET    (/:locale)/home/index(.:format)                                                          home#index {:locale=>/pt-BR|en/}
#                         home_calendar GET    (/:locale)/home/calendar(.:format)                                                       home#calendar {:locale=>/pt-BR|en/}
#                  home_calendar_events GET    (/:locale)/home/calendar_events(.:format)                                                home#calendar_events {:locale=>/pt-BR|en/}
#                          home_contact GET    (/:locale)/home/contact(.:format)                                                        home#contact {:locale=>/pt-BR|en/}
#                            home_about GET    (/:locale)/home/about(.:format)                                                          home#about {:locale=>/pt-BR|en/}
#                       home_set_locale GET    (/:locale)/home/set_locale(.:format)                                                     home#set_locale {:locale=>/pt-BR|en/}
#          admin_pages_database_changes GET    (/:locale)/admin_pages/database_changes(.:format)                                        admin_pages#database_changes {:locale=>/pt-BR|en/}
#                   admin_pages_sidekiq GET    (/:locale)/admin_pages/sidekiq(.:format)                                                 admin_pages#sidekiq {:locale=>/pt-BR|en/}
#                    admin_pages_pghero GET    (/:locale)/admin_pages/pghero(.:format)                                                  admin_pages#pghero {:locale=>/pt-BR|en/}
#                       global_settings GET    (/:locale)/global_settings(.:format)                                                     global_settings#index {:locale=>/pt-BR|en/}
#                   edit_global_setting GET    (/:locale)/global_settings/:id/edit(.:format)                                            global_settings#edit {:locale=>/pt-BR|en/}
#                        global_setting PATCH  (/:locale)/global_settings/:id(.:format)                                                 global_settings#update {:locale=>/pt-BR|en/}
#                                       PUT    (/:locale)/global_settings/:id(.:format)                                                 global_settings#update {:locale=>/pt-BR|en/}
#                         user_comments GET    (/:locale)/admin/users/:user_id/comments(.:format)                                       comments#index {:locale=>/pt-BR|en/}
#                                       POST   (/:locale)/admin/users/:user_id/comments(.:format)                                       comments#create {:locale=>/pt-BR|en/}
#                          user_comment DELETE (/:locale)/admin/users/:user_id/comments/:id(.:format)                                   comments#destroy {:locale=>/pt-BR|en/}
#                                 users GET    (/:locale)/admin/users(.:format)                                                         users#index {:locale=>/pt-BR|en/}
#                                       POST   (/:locale)/admin/users(.:format)                                                         users#create {:locale=>/pt-BR|en/}
#                              new_user GET    (/:locale)/admin/users/new(.:format)                                                     users#new {:locale=>/pt-BR|en/}
#                             edit_user GET    (/:locale)/admin/users/:id/edit(.:format)                                                users#edit {:locale=>/pt-BR|en/}
#                                  user GET    (/:locale)/admin/users/:id(.:format)                                                     users#show {:locale=>/pt-BR|en/}
#                                       PATCH  (/:locale)/admin/users/:id(.:format)                                                     users#update {:locale=>/pt-BR|en/}
#                                       PUT    (/:locale)/admin/users/:id(.:format)                                                     users#update {:locale=>/pt-BR|en/}
#                                       DELETE (/:locale)/admin/users/:id(.:format)                                                     users#destroy {:locale=>/pt-BR|en/}
#                mark_read_notification POST   (/:locale)/notifications/:id/mark_read(.:format)                                         notifications#mark_read {:locale=>/pt-BR|en/}
#           mark_all_read_notifications POST   (/:locale)/notifications/mark_all_read(.:format)                                         notifications#mark_all_read {:locale=>/pt-BR|en/}
#                         notifications GET    (/:locale)/notifications(.:format)                                                       notifications#index {:locale=>/pt-BR|en/}
#                                  root GET    /(:locale)(.:format)                                                                     home#index {:locale=>/pt-BR|en/}
#                                  site GET    /site(.:format)                                                                          statics#index
#                                       GET    /site/*other(.:format)                                                                   statics#index
#                                public GET    /public(.:format)                                                                        statics#public
#                                       GET    /public/*other(.:format)                                                                 statics#public
#                                       GET    /:locale(.:format)                                                                       home#index {:locale=>/pt-BR|en/}
#         rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                  action_mailbox/ingresses/postmark/inbound_emails#create
#            rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                     action_mailbox/ingresses/relay/inbound_emails#create
#         rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                  action_mailbox/ingresses/sendgrid/inbound_emails#create
#   rails_mandrill_inbound_health_check GET    /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#health_check
#         rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#create
#          rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                              action_mailbox/ingresses/mailgun/inbound_emails#create
#        rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#index
#                                       POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#create
#     new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                             rails/conductor/action_mailbox/inbound_emails#new
#    edit_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id/edit(.:format)                        rails/conductor/action_mailbox/inbound_emails#edit
#         rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#show
#                                       PATCH  /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       PUT    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       DELETE /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#destroy
# rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                      rails/conductor/action_mailbox/reroutes#create
#                    rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#             rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                    rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#             update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#                  rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
# 
# Routes for PgHero::Engine:
#                     space GET  (/:database)/space(.:format)                     pg_hero/home#space
#            relation_space GET  (/:database)/space/:relation(.:format)           pg_hero/home#relation_space
#               index_bloat GET  (/:database)/index_bloat(.:format)               pg_hero/home#index_bloat
#              live_queries GET  (/:database)/live_queries(.:format)              pg_hero/home#live_queries
#                   queries GET  (/:database)/queries(.:format)                   pg_hero/home#queries
#                show_query GET  (/:database)/queries/:query_hash(.:format)       pg_hero/home#show_query
#                    system GET  (/:database)/system(.:format)                    pg_hero/home#system
#                 cpu_usage GET  (/:database)/cpu_usage(.:format)                 pg_hero/home#cpu_usage
#          connection_stats GET  (/:database)/connection_stats(.:format)          pg_hero/home#connection_stats
#     replication_lag_stats GET  (/:database)/replication_lag_stats(.:format)     pg_hero/home#replication_lag_stats
#                load_stats GET  (/:database)/load_stats(.:format)                pg_hero/home#load_stats
#          free_space_stats GET  (/:database)/free_space_stats(.:format)          pg_hero/home#free_space_stats
#                   explain GET  (/:database)/explain(.:format)                   pg_hero/home#explain
#                      tune GET  (/:database)/tune(.:format)                      pg_hero/home#tune
#               connections GET  (/:database)/connections(.:format)               pg_hero/home#connections
#               maintenance GET  (/:database)/maintenance(.:format)               pg_hero/home#maintenance
#                      kill POST (/:database)/kill(.:format)                      pg_hero/home#kill
# kill_long_running_queries POST (/:database)/kill_long_running_queries(.:format) pg_hero/home#kill_long_running_queries
#                  kill_all POST (/:database)/kill_all(.:format)                  pg_hero/home#kill_all
#        enable_query_stats POST (/:database)/enable_query_stats(.:format)        pg_hero/home#enable_query_stats
#                           POST (/:database)/explain(.:format)                   pg_hero/home#explain
#         reset_query_stats POST (/:database)/reset_query_stats(.:format)         pg_hero/home#reset_query_stats
#              system_stats GET  (/:database)/system_stats(.:format)              redirect(301, system)
#               query_stats GET  (/:database)/query_stats(.:format)               redirect(301, queries)
#                      root GET  /(:database)(.:format)                           pg_hero/home#index
