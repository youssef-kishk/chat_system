bundle install
rails db:create
rails db:migrate
gnome-terminal -x rails s --port 3002
bundle exec sidekiq