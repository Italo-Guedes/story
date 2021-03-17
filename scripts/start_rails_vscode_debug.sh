#! /bin/sh

echo "starting rails server with vscode debug" && rm -f tmp/pids/server.pid && bundle exec rdebug-ide --host 0.0.0.0 --port 1234 -- bin/bundle exec puma -C config/puma.rb