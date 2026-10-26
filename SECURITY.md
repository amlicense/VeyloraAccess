# Security

This is an initial scaffold, not a production identity or endpoint security tool.
Administrative authentication and device trust are not implemented. The only
platform routes are the public scaffold page and application liveness endpoint.

Do not include credentials, private keys, employee records, or exploit payloads
in public issues. A private reporting channel has not yet been established;
maintainers should configure one before accepting sensitive reports.

Future security work must cover administrator MFA, scoped authorization, device
authentication, enrollment replay protection, directory delegation, update
signing, offline revocation, and tested recovery.
