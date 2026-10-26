Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.force_ssl = true
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.log_tags = [:request_id]
  config.logger = ActiveSupport::TaggedLogging.new(ActiveSupport::Logger.new($stdout))
  config.secret_key_base = ENV.fetch("SECRET_KEY_BASE")
  config.hosts = ENV.fetch("ALLOWED_HOSTS").split(",").map(&:strip)
  # A durable worker and production deployment are intentionally not configured.
end
