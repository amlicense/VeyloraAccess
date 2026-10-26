class GroupMembership < ApplicationRecord
  include OrganizationScoped
  belongs_to :organization
  belongs_to :group
  belongs_to :employee
  validates :employee_id, uniqueness: { scope: :group_id }
  same_organization :group, :employee
end
