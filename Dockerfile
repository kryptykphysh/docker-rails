FROM ruby:2.6
LABEL maintainer=kryptykphysh@kryptykphysh.xyz

ENV NODE_VERSION 11.10.0

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
  && git clone https://github.com/nodenv/nodenv.git ~/.nodenv \
  && echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> ~/.bashrc \
  && echo 'eval "$(nodenv init -)"' >> ~/.bashrc \
  && mkdir $HOME/.nodenv/plugins \
  && git clone https://github.com/nodenv/node-build.git $HOME/.nodenv/plugins/node-build \
  && . ~/.bashrc \
  && nodenv install $NODE_VERSION \
  && nodenv global $NODE_VERSION \
  # Install yarn executable
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list.d/yarn.list \
  && apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends yarn
