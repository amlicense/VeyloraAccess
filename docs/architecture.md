# Architecture boundaries

- Rails owns application authorization, employee workflows, and desired policies.
- Samba AD will own domain credentials and immutable Windows identities.
- PostgreSQL will store product state, not employee passwords.
- The Ruby agent will reconcile explicitly managed device state.
- Windows authenticates desktop sessions and enforces permissions.

Only a public scaffold page, Rails liveness route, and local agent diagnostics
exist. No domain or endpoint privilege operations are implemented.

Keep domain join separate from agent enrollment. Maintain stable directory SIDs.
Distinguish requested changes from confirmed application on a device. Add
administrative authentication and resource-scoped authorization before exposing
any business mutation or employee data.

Future integration boundaries: a directory adapter behind tracked provisioning
jobs, a versioned agent protocol with per-device authentication, and a narrowly
scoped Windows operations adapter. Avoid introducing empty implementations that
silently report success for security-sensitive operations.
