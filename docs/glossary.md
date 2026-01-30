# Glossary

Shared terminology and naming conventions used throughout this repository.

---

## Naming conventions (sanitized)

These are role-based aliases used in docs/diagrams/scripts. Replace with your SSH aliases, DNS, or VPN/WireGuard IPs in your environment.

- **gw-vpn** — VPN gateway / remote entry point VM (WireGuard endpoint, routing, choke point)
- **mon** — Monitoring VM (Prometheus, Grafana, alerting tools as applicable)
- **gpu** — GPU workload VM(s) (passthrough drivers, compute, remote workloads)
- **svc-\*** — Service VM(s) (internal workloads: apps, utilities, storage, experiments)

---

## Architecture terms

- **Control plane** — components used to manage the lab (e.g., Proxmox UI/API, SSH to host). Higher sensitivity.
- **Service plane** — VMs and workloads that provide services (apps, storage, experiments).
- **Trust zone** — a boundary grouping systems by trust level (WAN, LAN, VPN, Service zone).
- **Entry path** — the intended way administrative access enters the lab (VPN-only in this design).
- **Choke point** — a single point where access is centralized and can be audited/filtered (gw-vpn).

---

## Network and access

- **VPN-only access model** — services are not exposed publicly; admin/service access is restricted to the VPN network.
- **Allowlist** — explicit “permit only these sources/ports” policy (opposite of broad allow).
- **East–west traffic** — traffic between internal systems/VMs (as opposed to north–south WAN traffic).
- **North–south traffic** — traffic entering/leaving the lab to/from the internet.
- **Single NAT** — only one device performs NAT for the home network; avoids double NAT issues.

---

## Firewall terminology (iptables frontend)

- **iptables frontend** — operational tooling uses `iptables` commands and iptables-save style rules.
- **iptables (legacy)** — xtables backend (common on some older Debian/Proxmox hosts).
- **iptables (nf_tables)** — nftables backend via iptables-nft (common on modern Ubuntu/Debian VMs).
- **Default deny** — deny by default, allow only explicitly required flows.

---

## Observability

- **Prometheus** — metrics collection system that scrapes targets over HTTP.
- **Grafana** — dashboards/visualization for metrics and logs.
- **Exporter** — a service that exposes metrics in Prometheus format.
- **node_exporter** — exporter that exposes machine-level metrics (CPU, memory, disk, network).
- **Target** — an endpoint Prometheus scrapes (e.g., `http://<vm>:9100/metrics`).

---

## Operations and safety

- **Day-2 operations** — ongoing maintenance after initial setup: upgrades, audits, backups, troubleshooting.
- **Snapshot** — point-in-time VM state capture to enable rollback.
- **Rollback** — reverting to a known-good state after a failed change.
- **Maintenance window** — planned time to do changes requiring console/LAN access (reduces lockout risk).

---

## Sanitization policy

- **Sanitized** — identifiers and secrets are removed/replaced with placeholders.
- **Placeholder** — example value such as `10.0.0.0/24`, `example.internal`, `<CHANGE_ME>`.
- **Secret material** — keys, tokens, credentials, private configs; never committed to this repo.