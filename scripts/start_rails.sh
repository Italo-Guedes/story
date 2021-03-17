#! /bin/sh

echo "starting rails server" && rm -f tmp/pids/server.pid && bundle exec puma -C config/puma.rb