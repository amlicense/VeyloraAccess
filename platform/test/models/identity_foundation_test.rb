require "test_helper"

class IdentityFoundationTest < ActiveSupport::TestCase
  setup do
    @organization = Organization.create!(name: "Example", slug: "example")
    @other = Organization.create!(name: "Other", slug: "other")
    @employee = Employee.create!(organization: @organization, user: users(:one), first_name: "Alice", last_name: "Example", email: "alice@example.test")
    @device = Device.create!(organization: @organization, hostname: "PC-1", platform: "windows", enrollment_id: "device-one")
  end

  test "group membership rejects employees from another organization" do
    group = Group.create!(organization: @other, name: "Engineering")
    membership = GroupMembership.new(organization: @organization, group: group, employee: @employee)
    assert_not membership.valid?
    assert_includes membership.errors[:group], "must belong to the same organization"
  end

  test "policy revisions cannot be changed or destroyed" do
    policy = Policy.create!(organization: @organization, name: "Standard access")
    version = PolicyVersion.create!(organization: @organization, policy: policy, version: 1, rules: { "allow" => [] }, published_at: Time.current)
    assert_not version.update(rules: { "allow" => ["admin"] })
    assert_not version.destroy
    assert_equal({ "allow" => [] }, version.reload.rules)
  end

  test "an employee cannot approve their own elevation" do
    reviewer = Membership.create!(organization: @organization, user: users(:one), status: :active)
    request = AccessRequest.new(organization: @organization, employee: @employee, device: @device, reviewer: reviewer, status: :approved, reason: "Install tools", duration_minutes: 30)
    assert_not request.valid?
    assert_includes request.errors[:reviewer], "cannot approve their own request"
  end

  test "grant must match its approved request" do
    reviewer = Membership.create!(organization: @organization, user: users(:two), status: :active)
    request = AccessRequest.create!(organization: @organization, employee: @employee, device: @device, reviewer: reviewer, status: :approved, reason: "Install tools", duration_minutes: 30)
    other_device = Device.create!(organization: @organization, hostname: "PC-2", platform: "windows", enrollment_id: "device-two")
    grant = ElevationGrant.new(organization: @organization, access_request: request, employee: @employee, device: other_device, starts_at: Time.current, expires_at: 30.minutes.from_now, local_group_sid: "S-1-5-32-544")
    assert_not grant.valid?
    assert_includes grant.errors[:device], "must match request"
  end

  test "enrollment tokens can only be consumed once" do
    creator = Membership.create!(organization: @organization, user: users(:two))
    token = EnrollmentToken.create!(organization: @organization, created_by: creator, token_digest: "digest-only", expires_at: 10.minutes.from_now)
    token.consume!
    assert_raises(ActiveRecord::RecordInvalid) { token.consume! }
  end

  test "revoked and expired device credentials are unusable" do
    credential = DeviceCredential.new(organization: @organization, device: @device, fingerprint: "fingerprint", public_key: "public-key", issued_at: 1.hour.ago, expires_at: 1.hour.from_now)
    assert credential.usable?
    credential.revoked_at = Time.current
    assert_not credential.usable?
    credential.revoked_at = nil
    assert_not credential.usable?(at: 2.hours.from_now)
  end
end
