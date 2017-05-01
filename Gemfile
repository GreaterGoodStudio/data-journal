source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Rails, etc.
gem "rails", "~> 5.0.2"
gem "pg"
gem "puma", "~> 3.0"

# Assets
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "jquery-rails"
gem "turbolinks", "~> 5"
gem "less-rails-semantic_ui", "~> 2.2"
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
gem "draper", "3.0.0.pre1"

# Transactional Emails
gem "mandrill-api"

group :assets do
  gem "therubyracer", platforms: :ruby
end

group :production do
  gem "fog-aws"
  gem "rails_12factor"
end

group :development, :test do
  gem "byebug", platform: :mri
  gem "dotenv-rails", "~> 2.2"
  gem "rspec-rails", "~> 3.5"
  gem "faker", "~> 1.7"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "letter_opener"
  gem "rubocop", "~> 0.47.1", require: false
end
