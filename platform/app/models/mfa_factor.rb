class MfaFactor < ApplicationRecord
  belongs_to :user # Belongs to a user
  encrypts :secret
  enum :kind, { totp: 0 }
  validates :secret, presence: true
  validates :kind, uniqueness: { scope: :user_id }
end
