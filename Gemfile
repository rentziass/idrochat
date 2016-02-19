source 'https://rubygems.org'

ruby "2.3.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.beta2', '< 5.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma'
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
# Action Cable dependencies for the Redis adapter
gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem "slim-rails"

# Use Bower to manage your frontend assets
gem 'bower-rails'
gem 'bourbon'

########## MATERIALIZE
gem 'materialize-sass'

gem 'devise', git: "https://github.com/plataformatec/devise.git"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
end

group :development do
  gem 'rails-erd'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'better_errors'
  gem 'binding_of_caller'

  ########## DEPLOY
  ################# CAPISTRANO
  # gem 'capistrano'
  # gem 'capistrano-rails', '~> 1.1.0'
  # gem 'capistrano-passenger', git: 'git://github.com/capistrano/passenger'
  # gem 'capistrano-bundler'
  # gem 'capistrano-db-tasks', require: false
  # gem 'capistrano-rvm'
  # gem 'capistrano-sidekiq', github: 'seuros/capistrano-sidekiq'
  # gem 'highline'
  ################# CAPISTRANO

  ########## FRONTEND
  ################# GUARD LIVERELOAD
  gem "guard",       :require => false
  gem "guard-livereload",        :require => false
  gem "guard-rubocop"
  gem "rack-livereload"
  gem "rb-fsevent",              :require => false
  ################# GUARD LIVERELOAD
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
