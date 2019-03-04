# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.5.3'

gem 'rake'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1'
# Use postgres as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'bourbon'
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.8'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 1.0.0', group: :doc

gem 'bootsnap', require: false

gem 'autoprefixer-rails'
gem 'aws-sdk', '~> 2.3.0'
gem 'bootstrap', '~> 4.3.1'
gem 'chartkick'
gem 'clearance'
gem 'delayed_job_active_record'
gem 'delayed_paperclip'
gem 'figaro'
gem 'font-awesome-sass'
gem 'high_voltage', '~> 3.1.0'
gem 'imgkit'
gem 'jwt'
gem 'lodash-rails'
gem 'omniauth', '~> 1.9'
gem 'omniauth-instagram', '~> 1.3'
gem 'omniauth-oauth2', '~> 1.6'
gem 'paperclip', '~> 5.2.1'
gem 'puma'
gem 'react-rails'
gem 'render_anywhere', require: false
gem 'scenic'
gem 'serviceworker-rails'
gem 'simple_form'
gem 'u2f'
gem 'webpacker', '~> 4.0'
gem 'webpush'
gem 'wkhtmltoimage-binary'

gem 'hash_attribute_assignment'
# gem 'hash_attribute_assignment', path: '~/Projects/hash_attribute_assignment/'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end

group :development, :test do
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'fuubar', '~> 2.3'
  gem 'rspec-rails', '~> 3.8.2'
  gem 'rubocop-coreyja', '0.2.0'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'timecop'
end

group :development do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'web-console', '~> 3.7'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'rspec_junit_formatter'
  gem 'rubocop-junit-formatter'
end

group :production do
  gem 'rails_12factor'
end
