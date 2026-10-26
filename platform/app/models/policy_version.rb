class PolicyVersion < ApplicationRecord
  include OrganizationScoped
  belongs_to :organization
  belongs_to :policy
  has_many :device_policy_statuses, dependent: :restrict_with_exception
  validates :version, numericality: { only_integer: true, greater_than: 0 }, uniqueness: { scope: :policy_id }
  validates :rules, :published_at, presence: true
  same_organization :policy
  before_update { throw :abort }
  before_destroy { throw :abort }
end
