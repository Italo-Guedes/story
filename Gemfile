source 'https://rubygems.org'
ruby '2.7.4'

gem 'rails', '~> 6.0.3'
gem 'rails-i18n', '~> 6.0.0'


# Front end
gem 'react-rails'
gem 'webpacker'
gem 'turbolinks'

# File management
gem 'aws-sdk-s3', require: false
gem 'image_processing', '~> 1.2'

# Database related
gem 'paper_trail'
gem 'pg'
gem 'pg_search'
gem 'pghero'

# Front end (needed only because of pghero and graphiql)
gem 'coffee-rails'
gem 'sass-rails'
gem 'jquery-rails'

# Account management
gem 'cancancan'
gem 'devise'
gem 'devise-i18n'
gem 'rolify'

# better timezone info
gem 'tzinfo'
gem 'tzinfo-data'

# Json generation
gem 'jbuilder'
gem 'oj'

# Excel handling
# gem 'caxlsx'
# gem 'caxlsx_rails'
# gem 'roo', '1.13.2' # import

# PDF Generation
# gem 'wicked_pdf'
# gem 'wkhtmltopdf-binary', group: 'production'
# In order to generate PDFs locally, see dockerfile instructions

gem 'puma'

# Development produtivity
gem 'bootsnap'
gem 'cocoon'
gem 'figaro'
gem 'formtastic'
# gem 'money-rails'
gem 'sentry-raven'
gem 'will_paginate'
gem 'active_link_to'

# Background jobs
gem 'sidekiq'
gem 'sidekiq-cron'

group :development do
  gem 'annotate'
  gem 'web-console'

  gem 'derailed'

  # VSCode debugging
  gem 'debase'
  gem 'ruby-debug-ide'
end

group :development, :test do
  # Terminal Debugging
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-byebug'
  gem 'pry-rails'

  # tests
  gem 'capybara'
  gem 'cpf_faker'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'listen', '~> 3.0.5'
  gem 'rspec-rails', '~> 3.8'
  gem 'shoulda-matchers'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end