Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = ENV["CI"].present?
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.action_dispatch.show_exceptions = :rescuable
  config.action_controller.allow_forgery_protection = false
  config.active_job.queue_adapter = :test
  config.active_support.deprecation = :stderr
  config.secret_key_base = "test-only-" + "0" * 64
end
