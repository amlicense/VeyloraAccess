class Policy < ApplicationRecord
  belongs_to :organization
  has_many :policy_versions, dependent: :restrict_with_exception
  validates :name, presence: true, uniqueness: { scope: :organization_id }
  enum :status, { draft: 0, active: 1, retired: 2 }
end
