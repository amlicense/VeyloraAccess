class RoleAssignment < ApplicationRecord
  include OrganizationScoped
  belongs_to :organization
  belongs_to :membership
  belongs_to :administrative_role
  validates :administrative_role_id, uniqueness: { scope: :membership_id }
  same_organization :membership, :administrative_role
end
