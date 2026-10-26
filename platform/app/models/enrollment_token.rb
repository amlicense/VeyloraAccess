class EnrollmentToken < ApplicationRecord
  include OrganizationScoped
  belongs_to :organization
  belongs_to :created_by, class_name: "Membership"
  belongs_to :device, optional: true
  validates :token_digest, presence: true, uniqueness: true
  validates :expires_at, presence: true
  same_organization :created_by, :device

  # Call inside the enrollment transaction so device creation rolls back on reuse.
  def consume!
    with_lock do
      raise ActiveRecord::RecordInvalid, self unless consumed_at.nil? && expires_at > Time.current
      update!(consumed_at: Time.current)
    end
  end
end
