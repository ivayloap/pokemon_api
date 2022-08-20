require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

if ['development', 'test'].include? ENV['RAILS_ENV']
  Dotenv::Railtie.load
end

module PokemonApi
  class Application < Rails::Application
    config.load_defaults 7.0
    config.autoload_paths += Dir[Rails.root.join('services')]
    config.generators do |g|
      g.test_framework :rspec
    end
    config.api_only = true
  end
end
