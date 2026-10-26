class Membership < ApplicationRecord
  belongs_to :organization
  belongs_to :user
  has_many :role_assignments, dependent: :destroy
  validates :user_id, uniqueness: { scope: :organization_id }
  enum :status, { invited: 0, active: 1, suspended: 2 }
end
