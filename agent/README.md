# Ruby Windows agent

This scaffold currently exposes local runtime diagnostics only:

```powershell
bundle install
ruby bin/veylora-agent --version
ruby bin/veylora-agent --inventory
bundle exec rake test
```

Run from `agent/` with Ruby 3.4. Diagnostics also run on Linux for development.
There is no enrollment client, service installer, polling loop, local credential
store, or permission mutation yet. Do not install this as a privileged service.

Next: validate a Windows Ruby runtime distribution and service host in a disposable
Windows VM before adding authenticated communication or privileged operations.
See `docs/windows-lab.md` and `docs/architecture.md` at the repository root.
