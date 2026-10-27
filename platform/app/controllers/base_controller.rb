class BaseController < ApplicationController
  def index

    @title = "Veylora Access"

    @rails_version = Rails.version
    @ruby_version = RUBY_VERSION
    @os = RbConfig::CONFIG['host_os']
  end
end
