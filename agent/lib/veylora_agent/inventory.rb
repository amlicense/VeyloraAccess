require "rbconfig"

module VeyloraAgent
  # Local runtime diagnostics only; no device credentials or network activity.
  class Inventory
    def self.snapshot
      {
        agent_version: VERSION,
        ruby_version: RUBY_VERSION,
        platform: RbConfig::CONFIG.fetch("host_os"),
        windows: /mswin|mingw/i.match?(RbConfig::CONFIG.fetch("host_os"))
      }
    end
  end
end
