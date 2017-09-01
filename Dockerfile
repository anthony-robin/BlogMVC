FROM ruby:2.4.1-stretch
LABEL maintainer="Anthony ROBIN"

RUN apt-get update -qq
RUN apt-get install -y -qq build-essential chrpath libssl-dev libxft-dev curl \
  libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev \
  apt-transport-https \
  postgresql-client-common postgresql-client-9.6

# Nodejs and Npm
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq
RUN apt-get install -y -qq yarn

# Webkit
RUN apt-get install -y -qq libqt4-dev libqtwebkit-dev xvfb chromedriver

# Clean image to prevent it from being too fat
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    npm cache clear

# gemrc contains bundler instructions to skip installing documentation
RUN echo 'gem: --no-document' >> ~/.gemrc
RUN gem update --system --no-doc
RUN gem install bundler foreman

RUN mkdir -p /var/www
WORKDIR /var/www

COPY Gemfile /var/www/Gemfile
COPY Gemfile.lock /var/www/Gemfile.lock
RUN bundle install

COPY package.json /var/www/package.json
COPY yarn.lock /var/www/yarn.lock
RUN yarn install
