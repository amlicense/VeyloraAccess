# Development infrastructure

Root `compose.yml` provides a local PostgreSQL database and Rails development
container. Credentials are disposable lab values. Ports bind to localhost.
This is not a production deployment and includes no Samba domain controller.

Follow `docs/development.md` for first-run commands. The development image uses
floating patch tags; pin reviewed image digests before production deployment.

Samba requires a separate isolated domain lab with correct DNS, time, private
routing, and supported Windows clients. See `docs/windows-lab.md`.
