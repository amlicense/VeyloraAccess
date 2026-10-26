require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "authenticates the local dashboard password" do
    assert users(:one).authenticate("test-password-123")
    assert_not users(:one).authenticate("incorrect")
  end

  test "normalizes emails and rejects duplicate usernames" do
    user = User.new(username: "ALICE", email: " NEW@EXAMPLE.TEST ", first_name: "New", last_name: "User", password: "test-password-123")
    assert_not user.valid?
    assert_equal "new@example.test", user.email
    assert user.errors[:username].present?
  end
end
