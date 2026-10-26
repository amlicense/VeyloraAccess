# Windows integration lab

1. Create an isolated network and a disposable Linux Samba AD VM.
2. Configure a domain namespace you control, DNS, time, and private routing.
3. Snapshot a supported, domain-join-capable Windows VM.
4. Join the test domain and verify initial and cached employee sign-in.
5. Install Ruby 3.4 and run the agent's local diagnostics without elevation.
6. Evaluate runtime packaging and service lifecycle before privileged operations.

Record Windows edition/build, Ruby build/architecture, Samba version, service
host choice, and test results. A successful Linux agent unit test does not prove
Windows service compatibility.

Later tests must cover service failure, reboot, offline expiry, clock changes,
localized group names, immutable SIDs, existing elevated tokens, and recovery.
Use synthetic accounts. Do not connect this scaffold to a production directory.
