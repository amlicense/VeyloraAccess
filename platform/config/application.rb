require_relative "boot"
require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "rails/test_unit/railtie"
Bundler.require(*Rails.groups)

module VeyloraAccess
  class Application < Rails::Application
    config.load_defaults 8.1
    config.time_zone = "UTC"
    config.autoload_lib(ignore: %w[assets tasks])
    # No identity or permission mutations exist yet. Select a durable adapter
    # before introducing provisioning jobs.
    config.active_job.queue_adapter = :async
  end
end
