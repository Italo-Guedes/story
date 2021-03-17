FROM ruby:2.7.2-alpine

ENV APP_PATH /rdmapps
ENV BUNDLE_PATH /usr/local/bundle/gems

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

# Add a script to be executed every time the container starts, that erases the tmp/pids/server.pid file
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# rails server
EXPOSE 3000 
# yarn server
EXPOSE 3001
# for vscode debug
EXPOSE 1234
EXPOSE 26162

# Start the main process
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]