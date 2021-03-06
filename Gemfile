source 'https://rubygems.org'

ruby '2.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'
# Use sqlite3 as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Jquery mobile
gem 'jquery_mobile_rails', '1.4.0'

# Redis
gem "redis", "~> 3.0.1"
# Resque
gem 'resque', require: 'resque/server' # Resque web interface
gem 'resque-retry'
gem 'resque-scheduler'
gem 'resque_mailer'
gem 'exception_notification', github: 'daifu/exception_notification', branch: 'master'

# Cron job
gem 'whenever', :require => false

# create a better hash
gem 'hashie'

group :development, :test do
  gem 'byebug'
  gem 'delorean'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 2.13'
  gem 'mock_redis', '~> 0.13.0'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem "letter_opener" # View emails in browser instead of sending them
  gem 'bullet'
  gem 'meta_request'
  gem 'capistrano', '~> 2.15'
  gem 'rvm-capistrano'
  gem 'capistrano-ext'
end

group :test do
  gem 'capybara'
  gem 'coveralls', require: false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'webmock', require: false
  gem "codeclimate-test-reporter", require: false
end

group :production do
  gem 'rack-timeout'
  gem 'rails_12factor'
end
