class BaseController < ApplicationController
  def index

    @title = "Veylora Access"
    @description = "Veylora Access is a platform for managing access to Microsoft company services."
    @version = ENV["VERSION"] || "N/A"
    @commit_hash = ENV["COMMIT_HASH"] || "N/A"
    @build_date = ENV["BUILD_DATE"] || "N/A"

    @rails_version = Rails.version
    @ruby_version = RUBY_VERSION
    @os = RbConfig::CONFIG['host_os']
  end
end
