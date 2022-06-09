require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dimba
  class Application < Rails::Application
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :put, :delete, :options]
      end
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.api_only = true
    config.load_defaults 5.2
    config.time_zone = 'Africa/Nairobi'
    config.active_record.default_timezone = :local
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.autoload_paths << "#{Rails.root}/app/controllers/helpers"

    config.unverified_grace_period = 30.days
    config.unverified_reminder = 15.days
    config.days_to_archive_season = 1.day
  end
end
