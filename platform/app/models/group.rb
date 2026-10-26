class Group < ApplicationRecord
  belongs_to :organization
  has_many :group_memberships, dependent: :destroy
  has_many :employees, through: :group_memberships
  validates :name, presence: true, uniqueness: { scope: :organization_id }
  validates :directory_sid, :directory_object_id, uniqueness: { scope: :organization_id }, allow_nil: true
end
