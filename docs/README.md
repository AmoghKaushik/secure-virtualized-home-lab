# Documentation index

This folder contains the main documentation for the lab. All identifiers are sanitized.

## Start here
- [Architecture](./architecture.md) — overall system model and boundaries
- [Networking](./networking.md) — trust zones, routing, VPN-only access
- [Security](./security.md) — hardening approach, allowlists, threat assumptions
- [Operations](./operations.md) — day-2 checklist, safe change patterns, recovery
- [Inventory](./inventory.md) — sanitized “current deployment” view
- [Glossary](./glossary.md) — consistent naming and terms used across docs

## Decisions
- [ADRs](./adr/) — architecture decision records (trade-offs + rationale)

## Diagrams
- [Diagrams README](./diagrams/README.md) — how to view/export diagrams
- Common diagrams:
  - `docs/diagrams/network.md`
  - `docs/diagrams/vm-map.md`

## Templates and helpers
- [Config templates](../config/README.md)
- [Scripts](../scripts/README.md)
- Docker templates: `../docker/` (templates only; no secrets)