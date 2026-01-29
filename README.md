# Secure Virtualized Home Lab Infrastructure

This repository documents the design, decisions, and operational practices behind a personal home lab built to experiment with virtualization, networking, service isolation, and security hardening.

It is intentionally **documentation-first**: the goal is to capture *how and why* the system is designed and operated, not to publish a turnkey deployment.

---

## Scope

- Virtualization-first homelab design (Proxmox/KVM)
- Multi-VM service isolation and resource boundaries
- VPN-only remote access model
- Baseline host/VM hardening practices (SSH, firewalling, least privilege)
- Observability and operational practices (monitoring, backups, snapshots, recovery)

---

## Non-Goals

- Publishing production credentials, keys, tokens, or live configuration dumps
- Providing a one-click deployment or fully reproducible environment
- Exposing services directly to the public internet
- Sharing environment-specific identifiers (real IPs, domains, hostnames)

---

## Current System (High-Level)

- **Virtualization host:** Proxmox VE on Linux
- **Remote access:** WireGuard VPN (key-based)
- **Service model:** isolated VMs running Dockerized services as needed
- **Security posture:** default-deny mindset, allowlists, no public service exposure
- **Operational focus:** snapshots, controlled changes, and documented recovery paths

> Note: Concrete identifiers (IPs/domains/hostnames) are replaced with placeholders such as `10.0.0.0/24` and `example.internal`.

---

## Repository Structure

- `docs/` — architecture notes, networking model, security posture, operational runbooks
- `docs/adr/` — Architecture Decision Records (why decisions were made)
- `docs/diagrams/` — sanitized diagrams (editable sources + exports)
- `config/` — **example-only** configuration templates (`*.example`)
- `docker/` — container stack templates with `.env.example` files
- `scripts/` — safety checks and helper scripts (sanitized)

---

## How to Use This Repository

- Start with `docs/architecture.md` for the overall model
- Read `docs/networking.md` and `docs/security.md` for the access and hardening approach
- Use `docs/adr/` to understand the trade-offs behind key decisions
- Treat anything under `config/` and `docker/` as patterns/templates, not drop-in configs

---

## Security and Sanitization Policy

This repository does **not** contain:
- WireGuard private keys or live tunnel configs
- SSH private keys or authorized_keys
- DDNS tokens or API secrets
- Real internal/external addressing, hostnames, or domains

Only sanitized examples and placeholders are committed. See `SECURITY.md`.

---

## Technologies Used

- Linux
- Proxmox VE / KVM
- WireGuard
- Docker
- Firewalling (nftables/iptables patterns, sanitized)

---

## Status

This repository is actively evolving as the home lab grows. Documentation and templates are added incrementally, with a focus on correctness, safety, and clarity.