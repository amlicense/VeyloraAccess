class ProvisioningOperation < ApplicationRecord
  include OrganizationScoped
  belongs_to :organization
  belongs_to :employee, optional: true
  belongs_to :group, optional: true
  validates :operation, :idempotency_key, presence: true
  validates :idempotency_key, uniqueness: { scope: :organization_id }
  validates :attempts, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  enum :status, { pending: 0, running: 1, succeeded: 2, failed: 3, cancelled: 4 }
  same_organization :employee, :group
end
