class Device < ApplicationRecord
  include OrganizationScoped
  belongs_to :organization
  belongs_to :assigned_employee, class_name: "Employee", optional: true
  has_many :device_credentials, dependent: :restrict_with_exception
  has_many :device_policy_statuses, dependent: :restrict_with_exception
  has_many :access_requests, dependent: :restrict_with_exception
  has_many :elevation_grants, dependent: :restrict_with_exception
  validates :hostname, :platform, presence: true
  validates :enrollment_id, presence: true, uniqueness: true
  enum :status, { pending: 0, enrolled: 1, quarantined: 2, retired: 3 }
  enum :domain_status, { not_joined: 0, joining: 1, joined: 2, join_failed: 3 }, prefix: :domain
  same_organization :assigned_employee
end
