# Operations

This document describes day-2 operations: how the lab is maintained, changed safely, and recovered when something breaks.

## Operational Principles
- Small changes, committed documentation
- Prefer reversible actions (snapshots, staged rollouts)
- Test changes in isolation where possible
- Keep the hypervisor stable and boring

## Snapshots and Rollback
Recommended snapshot moments:
- Before firewall rewrites
- Before major package upgrades
- Before kernel/driver changes (especially GPU-related)
- Before changing routing/VPN behavior

Rollback strategy:
- Revert VM to last known-good snapshot
- Validate connectivity and critical services
- Re-apply changes incrementally with notes on what broke previously

## Backups
Goals:
- Recover VMs and essential data after disk failure or operator error
- Keep at least one backup target logically separate from the main storage

Common approach:
- Hypervisor-level VM backups (e.g., scheduled vzdump / backup server)
- Service-level backups for application data (databases, config volumes)

This repository may include templates and checklists, not live backup credentials or endpoints.

## Maintenance Checklist (Example)
- Review pending OS updates
- Check storage health and capacity
- Verify backups are recent and restorable
- Review monitoring dashboards for anomalies
- Audit firewall changes and access logs after major changes

## Change Log Discipline
When making impactful changes:
- Update the relevant doc/runbook
- Add an ADR if the change is a new architectural decision
- Keep commit messages descriptive enough to reconstruct intent