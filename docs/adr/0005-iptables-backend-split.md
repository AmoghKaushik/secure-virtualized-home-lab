# ADR: iptables frontend with mixed backends (legacy on host, nf_tables on VMs)

## Status
Accepted

## Context
Firewall policy in this lab is managed using the **iptables frontend**.
Current state:
- Proxmox host reports `iptables (legacy)`
- VMs report `iptables (nf_tables)` (iptables-nft)

Operationally, administration uses iptables commands and `iptables-save` style rules/templates.

## Decision
Document firewall policy using the iptables frontend and `iptables-save` templates.
Do not force backend unification yet; defer changes until a maintenance window with reliable console/LAN access.

## Consequences
- Firewall policy is expressed consistently using iptables syntax.
- Verification may differ by node:
  - Host: `iptables -S` is the primary view
  - VMs: `iptables -S` remains primary; `nft list ruleset` may show translated rules
- Backend unification remains a future option, not a requirement.