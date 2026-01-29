# ADR 0003: Virtualization-First Service Isolation

## Status
Accepted

## Context
Containers provide packaging and convenience, but they share a kernel and do not provide the same isolation boundary as a VM. The lab is used for experimenting with network services, security posture, and potentially higher-risk configurations. Stronger default isolation reduces blast radius and makes rollback/recovery cleaner.

## Decision
Use VMs as the primary isolation boundary. Containers (Docker) may be used inside selected service VMs for ease of deployment and upgrades, but the host is treated as a stable control plane and avoids running application services directly.

## Consequences
- Stronger isolation between service groups
- Clearer fault domains and easier rollback using VM snapshots
- Slightly higher resource overhead compared to “all-in-one Docker on host”
- More moving parts (VM lifecycle + container lifecycle)

## Notes
This approach intentionally optimizes for stability and learning over maximal density.