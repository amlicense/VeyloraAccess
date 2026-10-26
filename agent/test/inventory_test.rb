require "minitest/autorun"
require_relative "../lib/veylora_agent"

class InventoryTest < Minitest::Test
  def test_inventory_can_be_serialized_without_credentials
    require "json"
    snapshot = JSON.parse(JSON.generate(VeyloraAgent::Inventory.snapshot))
    assert_equal VeyloraAgent::VERSION, snapshot.fetch("agent_version")
    assert_includes [true, false], snapshot.fetch("windows")
    assert_equal %w[agent_version platform ruby_version windows], snapshot.keys.sort
  end

  def test_unsupported_cli_operation_fails
    require "open3"
    _, stderr, status = Open3.capture3(RbConfig.ruby,
      File.expand_path("../bin/veylora-agent", __dir__), "--enroll")
    assert_equal 64, status.exitstatus
    assert_includes stderr, "not implemented"
  end
end
