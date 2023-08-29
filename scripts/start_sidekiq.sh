#! /bin/sh

echo "starting sidekiq service" && bundle exec rdbg --port 3003 -n --open --host 0.0.0.0 -c "bundle exec sidekiq -c 6 -q default -q mailers -q active_storage_analysis -q active_storage_purge"