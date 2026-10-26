class CreateIdentityFoundation < ActiveRecord::Migration[8.1]
  def change
    change_table :users do |t|
      t.string :email, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :password_digest, null: false
      t.integer :status, null: false, default: 0
    end
    change_column_null :users, :username, false
    add_index :users, "lower(email)", unique: true
    add_index :users, "lower(username)", unique: true
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.jsonb :settings, null: false, default: {}
      t.timestamps
    end
    create_table :memberships do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.timestamps
    end
    create_table :employees do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.integer :status, null: false, default: 0
      t.string :directory_sid
      t.string :directory_object_id
      t.datetime :disabled_at
      t.timestamps
    end
    create_table :groups do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.string :directory_sid
      t.string :directory_object_id
      t.timestamps
    end
    create_table :group_memberships do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.timestamps
    end
    create_table :administrative_roles do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :name, null: false
      t.jsonb :permissions, null: false, default: {}
      t.timestamps
    end
    create_table :role_assignments do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :membership, null: false, foreign_key: true
      t.references :administrative_role, null: false, foreign_key: true
      t.timestamps
    end
    create_table :devices do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :assigned_employee, null: true, foreign_key: { to_table: :employees }
      t.string :hostname, null: false
      t.string :platform, null: false
      t.string :enrollment_id, null: false
      t.integer :status, null: false, default: 0
      t.integer :domain_status, null: false, default: 0
      t.string :serial_number
      t.string :agent_version
      t.datetime :last_seen_at
      t.jsonb :inventory, null: false, default: {}
      t.timestamps
    end
    create_table :device_credentials do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :device, null: false, foreign_key: true
      t.string :fingerprint, null: false
      t.text :public_key, null: false
      t.datetime :issued_at, null: false
      t.datetime :expires_at, null: false
      t.datetime :revoked_at
      t.timestamps
    end
    create_table :policies do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.integer :status, null: false, default: 0
      t.timestamps
    end
    create_table :policy_versions do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :policy, null: false, foreign_key: true
      t.integer :version, null: false
      t.jsonb :rules, null: false, default: {}
      t.datetime :published_at, null: false
      t.timestamps
    end
    create_table :device_policy_statuses do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :device, null: false, foreign_key: true
      t.references :policy_version, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.datetime :received_at
      t.datetime :applied_at
      t.datetime :failed_at
      t.string :error_code
      t.timestamps
    end
    create_table :access_requests do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.references :device, null: false, foreign_key: true
      t.references :reviewer, null: true, foreign_key: { to_table: :memberships }
      t.text :reason, null: false
      t.integer :duration_minutes, null: false
      t.integer :status, null: false, default: 0
      t.datetime :reviewed_at
      t.timestamps
    end
    create_table :elevation_grants do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :access_request, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.references :device, null: false, foreign_key: true
      t.datetime :starts_at, null: false
      t.datetime :expires_at, null: false
      t.string :local_group_sid, null: false
      t.integer :status, null: false, default: 0
      t.datetime :applied_at
      t.datetime :revoked_at
      t.timestamps
    end
    create_table :provisioning_operations do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :employee, null: true, foreign_key: true
      t.references :group, null: true, foreign_key: true
      t.string :operation, null: false
      t.string :idempotency_key, null: false
      t.integer :status, null: false, default: 0
      t.integer :attempts, null: false, default: 0
      t.datetime :next_attempt_at
      t.datetime :completed_at
      t.string :error_code
      t.jsonb :directory_result, null: false, default: {}
      t.timestamps
    end
    create_table :audit_events do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true
      t.string :action, null: false
      t.string :target_type, null: false
      t.string :target_identifier, null: false
      t.string :outcome, null: false
      t.datetime :occurred_at, null: false
      t.string :correlation_id, null: false
      t.jsonb :metadata, null: false, default: {}
      t.timestamps
    end
    create_table :sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :token_digest, null: false
      t.datetime :expires_at, null: false
      t.datetime :revoked_at
      t.string :ip_address
      t.string :user_agent
      t.timestamps
    end
    create_table :mfa_factors do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :kind, null: false, default: 0
      t.text :secret, null: false
      t.datetime :verified_at
      t.timestamps
    end
    create_table :passkeys do |t|
      t.references :user, null: false, foreign_key: true
      t.string :credential_id, null: false
      t.text :public_key, null: false
      t.integer :sign_count, null: false, default: 0
      t.string :name
      t.datetime :last_used_at
      t.timestamps
    end
    create_table :enrollment_tokens do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :created_by, null: false, foreign_key: { to_table: :memberships }
      t.references :device, null: true, foreign_key: true
      t.string :token_digest, null: false
      t.datetime :expires_at, null: false
      t.datetime :consumed_at
      t.timestamps
    end
    add_index :organizations, %i[slug], unique: true
    add_index :memberships, %i[organization_id user_id], unique: true
    add_index :employees, %i[organization_id email], unique: true
    add_index :employees, %i[organization_id directory_sid], unique: true
    add_index :employees, %i[organization_id directory_object_id], unique: true
    add_index :groups, %i[organization_id name], unique: true
    add_index :groups, %i[organization_id directory_sid], unique: true
    add_index :groups, %i[organization_id directory_object_id], unique: true
    add_index :group_memberships, %i[group_id employee_id], unique: true
    add_index :administrative_roles, %i[organization_id name], unique: true
    add_index :role_assignments, %i[membership_id administrative_role_id], unique: true
    add_index :devices, %i[enrollment_id], unique: true
    add_index :device_credentials, %i[fingerprint], unique: true
    add_index :policies, %i[organization_id name], unique: true
    add_index :policy_versions, %i[policy_id version], unique: true
    add_index :device_policy_statuses, %i[device_id policy_version_id], unique: true
    remove_index :elevation_grants, :access_request_id
    add_index :elevation_grants, %i[access_request_id], unique: true
    add_index :provisioning_operations, %i[organization_id idempotency_key], unique: true
    add_index :sessions, %i[token_digest], unique: true
    add_index :mfa_factors, %i[user_id kind], unique: true
    add_index :passkeys, %i[credential_id], unique: true
    add_index :enrollment_tokens, %i[token_digest], unique: true
    add_check_constraint :device_credentials, "expires_at > issued_at", name: "device_credentials_valid_values"
    add_check_constraint :elevation_grants, "expires_at > starts_at", name: "elevation_grants_valid_values"
    add_check_constraint :access_requests, "duration_minutes > 0 AND duration_minutes <= 1440", name: "access_requests_valid_values"
    add_check_constraint :policy_versions, "version > 0", name: "policy_versions_valid_values"
    add_check_constraint :provisioning_operations, "attempts >= 0", name: "provisioning_operations_valid_values"
    add_check_constraint :passkeys, "sign_count >= 0", name: "passkeys_valid_values"
  end
end
