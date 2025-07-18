require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_record/railtie'
require 'active_job/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_cable/engine'
require 'active_graph/railtie'
require 'action_mailer/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Konmego
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # config.load_defaults 5.2
    config.load_defaults 7.0
    config.active_job.queue_adapter = :delayed_job
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    config.generators { |g| g.orm :active_graph }
    config.logger = Logger.new(STDOUT)

    config.session_store :cookie_store, key: '_session_id'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore
    config.middleware.use config.session_store
    config.client = config_for(:client)
  end
end
