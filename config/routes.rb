# frozen_string_literal: true

Rails.application.routes.draw do
  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  draw(:admin)

  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    get 'versions/:model_name', to: 'versions#index', as: 'index_versions'
    get 'versions/:model_name/:id', to: 'versions#show', as: 'show_version'

    draw(:home)

    concern :commenteable do
      resources :comments, only: %i[index create destroy]
    end

    devise_for :users, controllers: { confirmations: 'users/confirmations' }

    resources :global_settings, only: %i[index edit update]
    resources :users, path: '/admin/users', concerns: :commenteable
    resources :notifications, only: [:index] do
      post 'mark_read', on: :member
      post 'mark_all_read', on: :collection
    end
    root to: 'home#index'
  end

  draw(:react)

  get '/:locale' => 'home#index', locale: /#{I18n.available_locales.join('|')}/
end
