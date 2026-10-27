# Development

## Container setup (recommended on Windows)

Prerequisite: Docker Engine with Compose and Linux containers enabled.
Run from the repository root. Generate the build metadata before running Compose:

```bash
./scripts/build-info.sh
```

```powershell
docker compose build
docker compose run --rm platform bundle install
docker compose run --rm platform bundle exec ruby bin/rails db:prepare
docker compose up platform
```

Open http://localhost:3000. `/up` reports application liveness only, not database
or directory readiness. There are no administrative or enrollment endpoints yet.

To display the current Git version, commit hash, and UTC build time on the status
page, run the build-info script before starting Compose:

```bash
./scripts/build-info.sh
docker compose up platform
```

The script uses the latest Git tag (or the commit hash if no tags exist), the
short current commit hash, and the current UTC time, and writes them to the
generated, ignored `build.txt` file. Run it again for each new build.

```powershell
docker compose run --rm -e RAILS_ENV=test platform bundle exec ruby bin/rails db:prepare test
docker compose run --rm platform bundle exec ruby bin/rails zeitwerk:check
docker compose run --rm -w /app/agent platform bundle install
docker compose run --rm -w /app/agent platform bundle exec rake test
docker compose stop
```

Dependencies are installed into a named volume; PostgreSQL data persists in its
own volume. `docker compose stop` preserves both. Initial `bundle install`
creates component-specific `Gemfile.lock` files: review and commit them once
resolved. They are deliberately not fabricated in this initial scaffold.

## Native Ruby setup

Install Ruby 3.4, Bundler, PostgreSQL 17, and PostgreSQL build dependencies.
Use WSL/Linux for Rails or validate the native Windows toolchain yourself.
Set the database environment variables from `.env.example` in your shell; the
file is documentation and is not automatically loaded.

```powershell
cd platform
bundle install
ruby bin/rails db:prepare
ruby bin/rails server
```

In another shell, run the agent commands documented in `agent/README.md`.

## Current limitations

No durable job worker, authentication, directory provisioning, Windows service
host, credentials, or production image is configured. Async jobs are development
only and must be replaced before account lifecycle work is implemented.
Hotwire is wired through import maps; use the container for initial dependency
resolution and commit lockfiles before treating builds as reproducible.
