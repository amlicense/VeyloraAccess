class Session < ApplicationRecord
  belongs_to :user
  validates :token_digest, presence: true, uniqueness: true
  validates :expires_at, presence: true
  scope :current, -> { where(revoked_at: nil).where("expires_at > ?", Time.current) }
end
