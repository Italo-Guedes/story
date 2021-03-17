#!/bin/sh
heroku pg:backups capture --app app-name
curl -o latest.dump `heroku pg:backups public-url --app app-name`
docker-compose run -e DISABLE_DATABASE_ENVIRONMENT_CHECK=1 web rake db:drop db:create
docker-compose run -e PGPASSWORD=postgres web pg_restore --clean --no-acl --no-owner -h db -U postgres -d app_dev latest.dump
docker-compose run web rake db:migrate