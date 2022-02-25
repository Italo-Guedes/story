FROM ruby:2.7.4-alpine

ENV APP_PATH /rdmapps
ENV BUNDLE_PATH /usr/local/bundle/gems
ENV RAILS_ENV production
ENV RACK_ENV production
ENV RAILS_SERVE_STATIC_FILES true


RUN apk add --no-cache --update build-base openssl tar bash linux-headers git \
    postgresql-dev tzdata postgresql-client less imagemagick python2 \
    npm yarn && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/cache/apk/*

RUN mkdir $APP_PATH
WORKDIR $APP_PATH

# Rails part
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3

# Webpacker part
# NOTE: Se der bronca pra compilar entra no container no yarn e roda "yarn install"
#       Isso vai atualizar o yarn.lock deixando ele coerente com a imagem
COPY package.json .
RUN yarn

# Copying app
COPY . .

RUN mkdir -p tmp/pids/
RUN mkdir -p tmp/logs/


RUN bundle exec rake assets:precompile

# rails server
EXPOSE 3000

# Start the main process
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]