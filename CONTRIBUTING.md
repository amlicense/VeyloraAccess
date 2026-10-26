# Contributing

Read `README.md`, `docs/architecture.md`, and `docs/development.md` first.
Keep application code in `platform/`, Ruby endpoint code in `agent/`, and
operational configuration in `infrastructure/`.

Run both component test suites and Rails `zeitwerk:check` before proposing changes.
Use Windows VMs for Windows integration. Describe failure and recovery behavior
for changes touching authentication, enrollment, local groups, or updates.
Never commit credentials, employee exports, private keys, or domain backups.

No license has been selected; do not assume permission to redistribute the code.
