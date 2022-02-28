web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -c 6 -q default -q mailers -q active_storage_analysis -q active_storage_purge
release: bundle exec rake db:migrate