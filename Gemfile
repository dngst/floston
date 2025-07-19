# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.4.1'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 8.0.0'

# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem 'propshaft'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 6.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem 'tailwindcss-rails', '~> 2.0'

# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem 'solid_cache', '~> 1.0'

gem 'solid_cable', '~> 3.0'

gem 'solid_queue', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :test do
  gem 'database_cleaner-active_record'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', require: false
end

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 6.0.0'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  gem 'rack-mini-profiler'

  gem 'hotwire-spark', '~> 0.1.12'
  gem 'rubocop-rails', require: false
  gem 'spring'
end

gem 'devise', '~> 4.9'

gem 'nested_form', '~> 0.3.2'

gem 'friendly_id', '~> 5.5'

gem 'ransack', '~> 4.0'

gem 'faker', '~> 3.2'

gem 'pagy', '~> 6.1'

gem 'kaminari', '~> 1.2'

gem 'httparty', '~> 0.21.0'

gem 'csv', '~> 3.3'

gem 'sqlite3', '~> 2.7'
