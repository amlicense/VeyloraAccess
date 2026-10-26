class AccessRequest < ApplicationRecord
  include OrganizationScoped
  belongs_to :organization
  belongs_to :employee
  belongs_to :device
  belongs_to :reviewer, class_name: "Membership", optional: true
  has_one :elevation_grant, dependent: :restrict_with_exception
  validates :reason, presence: true
  validates :duration_minutes, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 1440 }
  enum :status, { pending: 0, approved: 1, denied: 2, cancelled: 3, expired: 4 }
  same_organization :employee, :device, :reviewer
  validate do
    errors.add(:reviewer, "is required for a decision") if (approved? || denied?) && reviewer.nil?
    errors.add(:reviewer, "cannot approve their own request") if approved? && reviewer && employee && employee.user_id == reviewer.user_id
  end
end
