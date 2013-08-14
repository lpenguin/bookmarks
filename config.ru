# config.ru

gem 'mysql2'
require "./app"
run Sinatra::Application
