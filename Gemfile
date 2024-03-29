source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Use postgresql as the database for Active Record
gem 'postgresql'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# # Use SCSS for stylesheets
# gem 'sass-rails', '~> 5.0'
# # Use bootstrap for stylesheets
# gem 'bootstrap-sass'
# # Use rails jquery
# gem 'jquery-rails'
# # Use Uglifier as compressor for JavaScript assets
# gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# # Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem "active_model_serializers"
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'rack-cors'
gem 'sendgrid-ruby'
gem 'scout_apm'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'guard-rspec', require: false
  gem 'pry-rails'
  gem 'rspec-rails', ">= 2.0.0.beta"
  gem 'rspec', '~> 3.7'
  gem 'faker', '~> 1.9', '>= 1.9.1'
  gem 'simplecov', '~> 0.16.1'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rails-erd'
  gem 'rubocop', '~> 1.50.2', require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
  gem 'factory_bot_rails', '~> 4.10'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'database_cleaner'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "knock"
gem "pundit"

