class BaseController < ApplicationController
  def index

    @title = "Veylora Access"

    @version = Rails.application.config.version
    @commit_hash = Rails.application.config.commit_hash
    @build_date = Rails.application.config.build_date
    @rails_version = Rails.version
    @ruby_version = RUBY_VERSION
    @os = RbConfig::CONFIG['host_os']
  end
end
