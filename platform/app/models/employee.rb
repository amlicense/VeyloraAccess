class Employee < ApplicationRecord
  belongs_to :organization
  belongs_to :user, optional: true
  has_many :group_memberships, dependent: :destroy
  has_many :groups, through: :group_memberships
  has_many :devices, foreign_key: :assigned_employee_id, dependent: :nullify
  validates :first_name, :last_name, :email, presence: true
  normalizes :email, with: ->(value) { value.strip.downcase }
  validates :email, uniqueness: { scope: :organization_id }
  validates :directory_sid, :directory_object_id, uniqueness: { scope: :organization_id }, allow_nil: true
  enum :status, { pending: 0, provisioning: 1, active: 2, disabling: 3, disabled: 4, failed: 5 }
end
