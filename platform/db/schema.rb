# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_10_26_180000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "access_requests", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "employee_id", null: false
    t.bigint "device_id", null: false
    t.bigint "reviewer_id"
    t.text "reason", null: false
    t.integer "duration_minutes", null: false
    t.integer "status", default: 0, null: false
    t.datetime "reviewed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_access_requests_on_device_id"
    t.index ["employee_id"], name: "index_access_requests_on_employee_id"
    t.index ["organization_id"], name: "index_access_requests_on_organization_id"
    t.index ["reviewer_id"], name: "index_access_requests_on_reviewer_id"
    t.check_constraint "duration_minutes > 0 AND duration_minutes <= 1440", name: "access_requests_valid_values"
  end

  create_table "administrative_roles", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "name", null: false
    t.jsonb "permissions", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "name"], name: "index_administrative_roles_on_organization_id_and_name", unique: true
    t.index ["organization_id"], name: "index_administrative_roles_on_organization_id"
  end

  create_table "audit_events", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "user_id"
    t.string "action", null: false
    t.string "target_type", null: false
    t.string "target_identifier", null: false
    t.string "outcome", null: false
    t.datetime "occurred_at", null: false
    t.string "correlation_id", null: false
    t.jsonb "metadata", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_audit_events_on_organization_id"
    t.index ["user_id"], name: "index_audit_events_on_user_id"
  end

  create_table "device_credentials", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "device_id", null: false
    t.string "fingerprint", null: false
    t.text "public_key", null: false
    t.datetime "issued_at", null: false
    t.datetime "expires_at", null: false
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_device_credentials_on_device_id"
    t.index ["fingerprint"], name: "index_device_credentials_on_fingerprint", unique: true
    t.index ["organization_id"], name: "index_device_credentials_on_organization_id"
    t.check_constraint "expires_at > issued_at", name: "device_credentials_valid_values"
  end

  create_table "device_policy_statuses", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "device_id", null: false
    t.bigint "policy_version_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "received_at"
    t.datetime "applied_at"
    t.datetime "failed_at"
    t.string "error_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id", "policy_version_id"], name: "idx_on_device_id_policy_version_id_985ec353ed", unique: true
    t.index ["device_id"], name: "index_device_policy_statuses_on_device_id"
    t.index ["organization_id"], name: "index_device_policy_statuses_on_organization_id"
    t.index ["policy_version_id"], name: "index_device_policy_statuses_on_policy_version_id"
  end

  create_table "devices", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "assigned_employee_id"
    t.string "hostname", null: false
    t.string "platform", null: false
    t.string "enrollment_id", null: false
    t.integer "status", default: 0, null: false
    t.integer "domain_status", default: 0, null: false
    t.string "serial_number"
    t.string "agent_version"
    t.datetime "last_seen_at"
    t.jsonb "inventory", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_employee_id"], name: "index_devices_on_assigned_employee_id"
    t.index ["enrollment_id"], name: "index_devices_on_enrollment_id", unique: true
    t.index ["organization_id"], name: "index_devices_on_organization_id"
  end

  create_table "elevation_grants", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "access_request_id", null: false
    t.bigint "employee_id", null: false
    t.bigint "device_id", null: false
    t.datetime "starts_at", null: false
    t.datetime "expires_at", null: false
    t.string "local_group_sid", null: false
    t.integer "status", default: 0, null: false
    t.datetime "applied_at"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_request_id"], name: "index_elevation_grants_on_access_request_id", unique: true
    t.index ["device_id"], name: "index_elevation_grants_on_device_id"
    t.index ["employee_id"], name: "index_elevation_grants_on_employee_id"
    t.index ["organization_id"], name: "index_elevation_grants_on_organization_id"
    t.check_constraint "expires_at > starts_at", name: "elevation_grants_valid_values"
  end

  create_table "employees", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "user_id"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.integer "status", default: 0, null: false
    t.string "directory_sid"
    t.string "directory_object_id"
    t.datetime "disabled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "directory_object_id"], name: "index_employees_on_organization_id_and_directory_object_id", unique: true
    t.index ["organization_id", "directory_sid"], name: "index_employees_on_organization_id_and_directory_sid", unique: true
    t.index ["organization_id", "email"], name: "index_employees_on_organization_id_and_email", unique: true
    t.index ["organization_id"], name: "index_employees_on_organization_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "enrollment_tokens", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "created_by_id", null: false
    t.bigint "device_id"
    t.string "token_digest", null: false
    t.datetime "expires_at", null: false
    t.datetime "consumed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_enrollment_tokens_on_created_by_id"
    t.index ["device_id"], name: "index_enrollment_tokens_on_device_id"
    t.index ["organization_id"], name: "index_enrollment_tokens_on_organization_id"
    t.index ["token_digest"], name: "index_enrollment_tokens_on_token_digest", unique: true
  end

  create_table "group_memberships", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "group_id", null: false
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_group_memberships_on_employee_id"
    t.index ["group_id", "employee_id"], name: "index_group_memberships_on_group_id_and_employee_id", unique: true
    t.index ["group_id"], name: "index_group_memberships_on_group_id"
    t.index ["organization_id"], name: "index_group_memberships_on_organization_id"
  end

  create_table "groups", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "name", null: false
    t.text "description"
    t.string "directory_sid"
    t.string "directory_object_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "directory_object_id"], name: "index_groups_on_organization_id_and_directory_object_id", unique: true
    t.index ["organization_id", "directory_sid"], name: "index_groups_on_organization_id_and_directory_sid", unique: true
    t.index ["organization_id", "name"], name: "index_groups_on_organization_id_and_name", unique: true
    t.index ["organization_id"], name: "index_groups_on_organization_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "user_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "user_id"], name: "index_memberships_on_organization_id_and_user_id", unique: true
    t.index ["organization_id"], name: "index_memberships_on_organization_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "mfa_factors", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "kind", default: 0, null: false
    t.text "secret", null: false
    t.datetime "verified_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "kind"], name: "index_mfa_factors_on_user_id_and_kind", unique: true
    t.index ["user_id"], name: "index_mfa_factors_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.jsonb "settings", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_organizations_on_slug", unique: true
  end

  create_table "passkeys", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "credential_id", null: false
    t.text "public_key", null: false
    t.integer "sign_count", default: 0, null: false
    t.string "name"
    t.datetime "last_used_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["credential_id"], name: "index_passkeys_on_credential_id", unique: true
    t.index ["user_id"], name: "index_passkeys_on_user_id"
    t.check_constraint "sign_count >= 0", name: "passkeys_valid_values"
  end

  create_table "policies", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "name"], name: "index_policies_on_organization_id_and_name", unique: true
    t.index ["organization_id"], name: "index_policies_on_organization_id"
  end

  create_table "policy_versions", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "policy_id", null: false
    t.integer "version", null: false
    t.jsonb "rules", default: {}, null: false
    t.datetime "published_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_policy_versions_on_organization_id"
    t.index ["policy_id", "version"], name: "index_policy_versions_on_policy_id_and_version", unique: true
    t.index ["policy_id"], name: "index_policy_versions_on_policy_id"
    t.check_constraint "version > 0", name: "policy_versions_valid_values"
  end

  create_table "provisioning_operations", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "employee_id"
    t.bigint "group_id"
    t.string "operation", null: false
    t.string "idempotency_key", null: false
    t.integer "status", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.datetime "next_attempt_at"
    t.datetime "completed_at"
    t.string "error_code"
    t.jsonb "directory_result", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_provisioning_operations_on_employee_id"
    t.index ["group_id"], name: "index_provisioning_operations_on_group_id"
    t.index ["organization_id", "idempotency_key"], name: "idx_on_organization_id_idempotency_key_5f6d43d159", unique: true
    t.index ["organization_id"], name: "index_provisioning_operations_on_organization_id"
    t.check_constraint "attempts >= 0", name: "provisioning_operations_valid_values"
  end

  create_table "role_assignments", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "membership_id", null: false
    t.bigint "administrative_role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["administrative_role_id"], name: "index_role_assignments_on_administrative_role_id"
    t.index ["membership_id", "administrative_role_id"], name: "idx_on_membership_id_administrative_role_id_8742bb26b5", unique: true
    t.index ["membership_id"], name: "index_role_assignments_on_membership_id"
    t.index ["organization_id"], name: "index_role_assignments_on_organization_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "token_digest", null: false
    t.datetime "expires_at", null: false
    t.datetime "revoked_at"
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token_digest"], name: "index_sessions_on_token_digest", unique: true
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "password_digest", null: false
    t.integer "status", default: 0, null: false
    t.index "lower((email)::text)", name: "index_users_on_lower_email", unique: true
    t.index "lower((username)::text)", name: "index_users_on_lower_username", unique: true
  end

  add_foreign_key "access_requests", "devices"
  add_foreign_key "access_requests", "employees"
  add_foreign_key "access_requests", "memberships", column: "reviewer_id"
  add_foreign_key "access_requests", "organizations"
  add_foreign_key "administrative_roles", "organizations"
  add_foreign_key "audit_events", "organizations"
  add_foreign_key "audit_events", "users"
  add_foreign_key "device_credentials", "devices"
  add_foreign_key "device_credentials", "organizations"
  add_foreign_key "device_policy_statuses", "devices"
  add_foreign_key "device_policy_statuses", "organizations"
  add_foreign_key "device_policy_statuses", "policy_versions"
  add_foreign_key "devices", "employees", column: "assigned_employee_id"
  add_foreign_key "devices", "organizations"
  add_foreign_key "elevation_grants", "access_requests"
  add_foreign_key "elevation_grants", "devices"
  add_foreign_key "elevation_grants", "employees"
  add_foreign_key "elevation_grants", "organizations"
  add_foreign_key "employees", "organizations"
  add_foreign_key "employees", "users"
  add_foreign_key "enrollment_tokens", "devices"
  add_foreign_key "enrollment_tokens", "memberships", column: "created_by_id"
  add_foreign_key "enrollment_tokens", "organizations"
  add_foreign_key "group_memberships", "employees"
  add_foreign_key "group_memberships", "groups"
  add_foreign_key "group_memberships", "organizations"
  add_foreign_key "groups", "organizations"
  add_foreign_key "memberships", "organizations"
  add_foreign_key "memberships", "users"
  add_foreign_key "mfa_factors", "users"
  add_foreign_key "passkeys", "users"
  add_foreign_key "policies", "organizations"
  add_foreign_key "policy_versions", "organizations"
  add_foreign_key "policy_versions", "policies"
  add_foreign_key "provisioning_operations", "employees"
  add_foreign_key "provisioning_operations", "groups"
  add_foreign_key "provisioning_operations", "organizations"
  add_foreign_key "role_assignments", "administrative_roles"
  add_foreign_key "role_assignments", "memberships"
  add_foreign_key "role_assignments", "organizations"
  add_foreign_key "sessions", "users"
end
