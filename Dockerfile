FROM ruby:2.6
LABEL maintainer=kryptykphysh@kryptykphysh.xyz

RUN apt-get update -yqq \
  # Install required apt tools
  && apt-get install -yqq --no-install-recommends \
    apt-transport-https \
    apt-utils \
  # Update gem and install base required gems
  && gem update --system \
  && gem update bundler \
  && gem install \
    minitest \
    rails \
    rake \
  # Install nodenv and desired node version
  && curl -sL https://deb.nodesource.com/setup_11.x | bash - \
  # Setup Yarn repository
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list.d/yarn.list \
  # Setup Postgres repository
  && curl -sS https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" >> /etc/apt/sources.list.d/pg.list \
  # Install Yarn and Postgresql client tools
  && apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
    libpq-dev \
    nodejs \
    postgresql-client \
    yarn \
  && rm -rf /var/lib/apt/lists/*
