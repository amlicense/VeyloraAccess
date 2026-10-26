class DeviceCredential < ApplicationRecord
  include OrganizationScoped
  belongs_to :organization
  belongs_to :device
  validates :fingerprint, presence: true, uniqueness: true
  validates :public_key, :issued_at, :expires_at, presence: true
  validate :validity_window
  same_organization :device

  def usable?(at: Time.current)
    revoked_at.nil? && issued_at.present? && expires_at.present? && issued_at <= at && expires_at > at
  end

  private

  def validity_window
    errors.add(:expires_at, "must follow issue time") if issued_at && expires_at && expires_at <= issued_at
  end
end
