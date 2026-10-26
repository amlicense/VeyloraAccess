class DevicePolicyStatus < ApplicationRecord
  include OrganizationScoped
  belongs_to :organization
  belongs_to :device
  belongs_to :policy_version
  validates :policy_version_id, uniqueness: { scope: :device_id }
  enum :status, { desired: 0, received: 1, applied: 2, failed: 3 }
  same_organization :device, :policy_version
end
