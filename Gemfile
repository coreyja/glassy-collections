source 'https://rubygems.org'
ruby '2.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'
# Use postgres as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'bourbon'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'chartkick'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'paperclip', '~> 4.3'
gem 'aws-sdk-v1'

gem 'delayed_job_active_record'
gem 'delayed_paperclip'

gem 'clearance'
gem 'omniauth'
gem 'omniauth-instagram'

gem 'figaro'

gem 'simple_form'

gem 'hash_attribute_assignment'
# gem 'hash_attribute_assignment', path: '~/Projects/hash_attribute_assignment/'

gem 'bootstrap', '~> 4.0.0.alpha3'
gem 'autoprefixer-rails'
source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end
gem 'font-awesome-sass'

gem 'imgkit'
gem 'wkhtmltoimage-binary'

gem 'high_voltage', '~> 2.4.0'

gem 'render_anywhere', require: false

gem 'scenic'

gem 'rubocop'
gem 'scss_lint', require: false

gem 'serviceworker-rails'
gem 'webpush'

gem 'lodash-rails'

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'timecop'

  gem 'factory_girl_rails'
end

group :test do
  gem 'codeclimate-test-reporter', require: nil
end

group :development do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'pry-rails'
  gem 'pry-remote'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
  gem 'newrelic_rpm'
  gem 'rails_12factor'
end
