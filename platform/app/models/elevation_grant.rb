class ElevationGrant < ApplicationRecord
  include OrganizationScoped
  belongs_to :organization
  belongs_to :access_request
  belongs_to :employee
  belongs_to :device
  validates :access_request_id, uniqueness: true
  validates :starts_at, :expires_at, :local_group_sid, presence: true
  enum :status, { pending: 0, applied: 1, revoking: 2, revoked: 3, expired: 4, failed: 5 }
  same_organization :access_request, :employee, :device
  validate do
    errors.add(:expires_at, "must follow start time") if starts_at && expires_at && expires_at <= starts_at
    if access_request
      errors.add(:access_request, "must be approved") unless access_request.approved?
      errors.add(:employee, "must match request") unless employee_id == access_request.employee_id
      errors.add(:device, "must match request") unless device_id == access_request.device_id
      if starts_at && expires_at && access_request.duration_minutes && expires_at > starts_at + access_request.duration_minutes.minutes
        errors.add(:expires_at, "exceeds approved duration")
      end
    end
  end
end
