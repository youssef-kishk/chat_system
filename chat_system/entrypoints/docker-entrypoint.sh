#!/bin/bash

bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rspec
bundle exec rails s -b 0.0.0.0
