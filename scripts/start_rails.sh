#! /bin/sh

echo "starting rails server" && \
rm -f tmp/pids/server.pid && \
bundle exec rdbg --port 3002 -n --open --host 0.0.0.0 -c "bundle exec puma -C config/puma.rb"