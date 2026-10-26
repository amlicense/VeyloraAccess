# Rails platform

Ruby 3.4, Rails 8.1, PostgreSQL, and Hotwire. Run commands from this directory
unless using the root Docker Compose setup.

See [development setup](../docs/development.md) for prerequisites and commands.

Current routes:

- `/`: public scaffold status page.
- `/up`: application liveness; does not check PostgreSQL or Samba readiness.

Application controllers, models, jobs, views, assets, configuration, and tests
follow standard Rails conventions. No employee records, authentication flows,
agent API, or permission mutations exist yet. Add authentication and authorization
before administrative features. Select a durable Active Job adapter before
provisioning work; the current async adapter is for development only.
