FROM ruby:2.7.4

RUN apt-get update && apt-get install

COPY . /app

WORKDIR /app

RUN bundle install

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]