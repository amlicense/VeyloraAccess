class User < ApplicationRecord
  has_secure_password

  # Organization memberships
  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships
  has_many :companies, through: :memberships, source: :organization

  # Authentication
  has_many :sessions, dependent: :destroy
  has_many :mfa_factors, dependent: :destroy
  has_many :passkeys, dependent: :destroy

  # Security
  has_many :audit_events, dependent: :restrict_with_exception
  has_many :audit_logs, class_name: "AuditEvent", dependent: :restrict_with_exception

  enum :status, {
    pending: 0,
    active: 1,
    inactive: 2,
    suspended: 3,
    locked: 4
  }

  normalizes :email, with: ->(email) {
    email.strip.downcase
  }

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { in: 3..30 },
            format: { with: /\A[a-zA-Z0-9_]+\z/ }

  validates :first_name, :last_name, presence: true

  def active_for_authentication?
    active?
  end
end
