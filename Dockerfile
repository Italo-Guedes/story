FROM ruby:3.0.4

ENV APP_PATH /rdmapps
ENV BUNDLE_PATH /usr/local/bundle/gems
ENV BUNDLE_VERSION 2.2.3
ENV RAILS_ENV production
ENV RACK_ENV production
ENV RAILS_SERVE_STATIC_FILES true

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    nodejs npm postgresql-client

RUN npm install -g yarn

RUN mkdir $APP_PATH
WORKDIR $APP_PATH

# Install Python 2.7.9
RUN apt-get install -y \
    build-essential \
    zlib1g-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libsqlite3-dev \
    libreadline-dev \
    libffi-dev \
    wget

RUN wget https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tgz && \
    tar xzf Python-2.7.9.tgz && \
    cd Python-2.7.9 && \
    ./configure --enable-optimizations && \
    make altinstall && \
    ln -s /usr/local/bin/python2.7 /usr/local/bin/python


# Rails part
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3

# Webpacker part
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