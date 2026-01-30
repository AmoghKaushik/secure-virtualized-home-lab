# Inventory (Sanitized)

This document is a high-level inventory of the lab. It intentionally omits IPs, domains, hostnames, keys, and secrets.

## Conventions used here
- VM IDs are shown as **ranges** (e.g., `VM-1xx`) to avoid disclosing exact identifiers.
- Names like `gw-vpn`, `mon`, `gpu`, `svc-*` are **role aliases** used in docs/diagrams.

## Virtualization host (control plane)
- Platform: Proxmox VE
- Role: VM lifecycle, storage orchestration, control plane
- Exposure: management interfaces should be reachable **only via VPN / allowlists**

## Core VMs

### VM-1xx — `gw-vpn` (VPN gateway)
- Purpose: WireGuard endpoint + controlled entry path for administration
- Typical sizing: 1–2 vCPU, 1–2 GB RAM, 8–16 GB disk
- Key services:
  - WireGuard `51820/udp`
  - SSH `22/tcp` (VPN-only)
  - node_exporter `9100/tcp` (allowlisted)

### VM-3xx — `mon` (monitoring)
- Purpose: Prometheus + Grafana (and related monitoring utilities)
- Typical sizing: 1–2 vCPU, 2–4 GB RAM, 16–64 GB disk (depends on retention)
- Key services (VPN-only):
  - Prometheus UI `9090/tcp`
  - Grafana UI `3000/tcp`
  - node_exporter `9100/tcp` (allowlisted)
- Notes:
  - Prometheus pulls metrics from exporters on long-running VMs.

### VM-5xx — `gpu` (GPU workloads)
- Purpose: GPU passthrough workloads (compute/experiments/remote desktop)
- Typical sizing: varies; commonly 4–8 vCPU, 8–16 GB RAM, disk as needed
- Notes:
  - treated as higher-risk surface (drivers/experiments); isolate and allowlist ports
  - node_exporter enabled on stable GPU VMs

## Service VMs (current + future)

### `svc-*` — service VM group
- Purpose: internal services such as apps, utilities, storage helpers, installers, experiments
- Typical sizing: depends on service (prefer smallest that meets requirements)
- Observability:
  - node_exporter enabled on stable/long-running service VMs
- Exposure:
  - no WAN exposure; internal-only + allowlists via `gw-vpn`

## Service map (high level)
- Admin access path: Client → VPN → `gw-vpn` → (Proxmox / VMs) via allowlists
- Metrics path: `mon` → exporters (`9100` and service-specific exporters) on `gw-vpn`, `gpu`, and `svc-*`