FROM ruby:2.6.3

RUN apt-get update -qq && apt-get upgrade -y && apt-get install -y vim imagemagick libmagic-dev libmagickwand-dev

COPY . /app

WORKDIR /app

RUN gem install bundler && bundle install
