FROM ruby:2.4.1-jessie
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /dimba-api
WORKDIR /dimba-api
COPY Gemfile /dimba-api/Gemfile
COPY Gemfile.lock /dimba-api/Gemfile.lock
RUN bundle install
COPY . /dimba-api
