source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Rails, etc.
gem "rails", "~> 5.1.6"
gem "pg"
gem "puma", "~> 3.7"

# Assets
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "jquery-rails"
gem "turbolinks", "~> 5"
gem "less-rails-semantic_ui", "2.3.0"
gem "jquery-fileupload-rails", "~> 0.4"

# Authentication
gem "devise", "~> 4.2"
gem "devise_invitable", "~> 1.7"
gem "pundit", "~> 1.1"

# File attachments
gem "mini_magick"
gem "carrierwave", "~> 1.0"
gem "carrierwave_direct"

# Pagination
gem "kaminari", "~> 1.0"

# Friendly IDs
gem "friendly_id", "~> 5.1"

# Redis
gem "redis-rails", "~> 5.0"

# Background jobs
gem "sidekiq", "~> 4.2"

# Active links
gem "active_link_to", "~> 1.0"

# Package management
gem "bower-rails", "~> 0.11"

# Decorators
gem "draper", "3.0"

# Transactional Emails
gem "mandrill-api"

# CORS
gem "rack-cors", "~> 0.4"

# Static Pages
gem "high_voltage", "~> 3.0"

# Tree data structure
gem "ancestry", "~> 2.2"

# Edit in place
gem "best_in_place", "~> 3.0"

# ZIP files
gem "zipline", "~> 0.0.12"

# Possesive nouns
gem "possessive"

# PDF
gem "wicked_pdf", "~> 1.1"

# Custom error pages
gem "gaffe", "~> 1.2"

group :assets do
  gem "therubyracer", platforms: :ruby
end

group :staging, :production do
  gem "fog-aws"
  gem "rails_12factor"
  gem "wkhtmltopdf-heroku", "~> 2.0"
end

group :development, :test do
  gem "byebug", platform: :mri
  gem "dotenv-rails", "~> 2.2"
  gem "faker", "~> 1.7"
  gem "wkhtmltopdf-binary", "~> 0.12"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "letter_opener"
  # gem "rubocop", "~> 0.49", require: false
end

group :test do
  gem "capybara", "~> 2.13"
  gem "poltergeist", "~> 1.15"
  gem "factory_bot_rails", "~> 4.11"
  gem "database_cleaner", "~> 1.6"
  gem "shoulda", "~> 3.5"
  gem "shoulda-matchers", "~> 2.0"
  gem "simplecov", "~> 0.14", require: false
end
