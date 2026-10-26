class AuditEvent < ApplicationRecord
  belongs_to :organization
  belongs_to :user, optional: true
  validates :action, :target_type, :target_identifier, :outcome, :occurred_at, :correlation_id, presence: true
  before_update { throw :abort }
  before_destroy { throw :abort }
end
