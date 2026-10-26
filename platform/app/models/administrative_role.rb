class AdministrativeRole < ApplicationRecord
  belongs_to :organization
  has_many :role_assignments, dependent: :restrict_with_exception
  validates :name, presence: true, uniqueness: { scope: :organization_id }
  validates :permissions, presence: true
end
