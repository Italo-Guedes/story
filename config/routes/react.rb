# frozen_string_literal: true

# config/routes/react.rb
get 'site', to: 'react#index', as: 'site'
get 'site/*other', to: 'react#index'

get 'public', to: 'react#public', as: 'public'
get 'public/*other', to: 'react#public'
