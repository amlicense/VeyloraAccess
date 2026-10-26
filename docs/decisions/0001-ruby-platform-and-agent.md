# ADR 0001: Ruby application and agent

Status: accepted for initial scaffolding.

Use Ruby on Rails with PostgreSQL and Hotwire for the control plane. Use Ruby for
the Windows agent as explicitly selected by the project owner. Use Samba AD as
the proposed native Windows authentication layer.

The agent must prove runtime packaging, Windows service hosting, and native API
access before security-sensitive implementation. A custom Windows Credential
Provider is outside the initial scope and would require native integration.

Keep platform and agent dependency sets separate. Resolve and commit lockfiles
with the first available Ruby toolchain. This repository does not yet claim a
deployable identity service or packaged Windows service.
