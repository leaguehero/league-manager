source 'https://rubygems.org'
ruby '2.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
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

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Devise gem
gem 'devise'
# Gem to allow users to invite other users
gem 'devise_invitable', '~> 1.5.2'

# For better printing
gem 'awesome_print'

# Sidekiq for background jobs
# make sure to run 'redis-server' then 'bundle exec sidekiq' to run
gem 'sidekiq'

# for sending background emails
gem 'devise-async'

# web server
gem 'puma'

# SEO
gem 'meta-tags'

# bootstrap for stylesheets
gem 'bootstrap', '~> 4.0.0.alpha3'

# simple_form for bootstrap
gem 'simple_form'

# stripe gem for payment processing
gem 'stripe'
gem 'stripe_event'
# gem for allow multi tenantcy database
gem 'apartment'
# for storing tenant name in Sidekiq
gem 'apartment-sidekiq'
# for editing attributes in place with AJAX
gem 'best_in_place'
# schedule generator
gem 'rrschedule'
# paperclip for uploading images
gem "paperclip", "~> 4.3"
# to save files to aws
gem 'aws-sdk','< 2.0'
# file to hide ENV variables
gem 'figaro'

# Access an IRB console on exception pages or by using <%= console %> in views
gem 'web-console', '~> 2.0', group: :development

group :development, :test do
  # Environment variables
  gem 'dotenv-rails'
  # to see emails in development
  gem "letter_opener"
  # webhook for localhost
  gem 'ultrahook'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # shows test coverage on code base
  gem 'simplecov', :require => false
  # testing framework
  gem 'rspec-rails', '~> 3.0'

end

gem 'rails_12factor', group: :production
