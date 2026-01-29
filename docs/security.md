# Security Posture

This home lab applies production-style security practices where practical, while keeping complexity proportional to the environment.

## Threat Model (Lightweight)
Assumptions:
- The internet is hostile and unauthenticated scans are expected
- LAN devices may be compromised (IoT risk) or misconfigured
- Administrator mistakes are a realistic risk (accidental exposure, bad firewall rules)

Goals:
- Prevent public exposure of internal services
- Constrain admin access to a controlled path (VPN)
- Reduce blast radius via isolation (VM boundaries)
- Make recovery practical (snapshots, backups)

## Access Control
- Remote access is restricted to VPN
- Administrative access uses SSH with **public key authentication**
- Password-based remote access is avoided
- Least privilege: services do not run as root unless required

## Firewall Philosophy
- Default deny for inbound traffic where feasible
- Explicit allowlists for:
  - VPN ingress (WireGuard)
  - SSH from VPN subnet only
  - Monitoring ports only from the monitoring network/source
- Prefer narrow rules: specific port + specific source + specific destination

Note: Rules committed to this repository are provided only as **sanitized examples**.

## Secrets Handling
- No secrets are committed
- Use `.env.example` for documentation and local `.env` for real values
- Keys/tokens live outside version control
- Prefer rotation-friendly patterns (replace keys, redeploy, revoke old)

## Update Strategy
- Keep host and critical VMs updated on a schedule
- Prefer planned maintenance windows for disruptive upgrades
- Snapshot before high-risk changes (kernel, drivers, firewall rewrites)

## Logging & Observability (Security-Relevant)
- Monitor availability and resource usage
- Track authentication failures and suspicious patterns where practical
- Prefer centralized dashboards/metrics over ad-hoc debugging on production-like VMs