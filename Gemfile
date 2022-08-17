source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.1"

gem "rails", "~> 7.0.3", ">= 7.0.3.1"

gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem 'bootsnap'

group :development, :test do
  gem 'dotenv-rails'
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
end

group :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
