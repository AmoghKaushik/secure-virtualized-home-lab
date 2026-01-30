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

---

## Day-2 checklist (post-change / post-reboot sanity)

Run this checklist after:
- firewall / SSH / VPN changes
- package upgrades
- VM reboots
- Prometheus/Grafana config edits

### Naming used in this document
- `gw-vpn` — WireGuard gateway / remote entry point VM
- `mon` — monitoring VM (Prometheus/Grafana)
- `gpu` — GPU workload VM(s)
- `svc-*` — service VM(s) (any long-running internal workloads)

In practice, substitute these with your SSH aliases or VPN/WireGuard IPs.

### Ports (defaults / common)
- WireGuard: `51820/udp` (on `gw-vpn`)
- SSH: `22/tcp` (restricted to VPN subnet)
- node_exporter: `9100/tcp` (restricted to monitoring/VPN subnet)
- Prometheus UI: `9090/tcp`
- Grafana UI: `3000/tcp`

### 1) From VPN client (admin machine)
1. Confirm VPN is up (WireGuard client shows connected).
2. Confirm reachability over VPN (use WG IPs or SSH aliases):
   - `ping gw-vpn`
   - `ping mon`
   - `ping gpu`
3. Confirm SSH key-only still holds (no password prompts):
   - `ssh gw-vpn`
   - `ssh mon`
   - `ssh gpu`

If any SSH command asks for a password, stop and verify sshd hardening and whether cloud-init reverted settings.

### 2) On `gw-vpn` (VPN entry point)
1. WireGuard interface and peer state:
   - `sudo wg show`
2. Routing state (gateway only):
   - `sysctl net.ipv4.ip_forward`
     - expected: `1` on `gw-vpn`
3. Firewall sanity (iptables frontend):
   - `sudo iptables -S`
   - confirm allowlist exists for:
     - UDP 51820
     - SSH 22 from VPN subnet only
     - node_exporter 9100 from monitoring/VPN subnet only
   - when changing firewall rules, prefer console access or keep an active session open until verified
4. Confirm nothing is listening unexpectedly:
   - `sudo ss -tulpn`

### 3) On Proxmox host (control plane)
1. Confirm web UI is listening as expected:
   - `sudo ss -tulpn | grep 8006`
2. Confirm firewall posture still matches intended access model:
   - `sudo iptables -S`
3. (Optional) Confirm you can reach the UI only via VPN:
   - `https://<pve-host-or-alias>:8006`

### 4) On `mon` (Prometheus/Grafana VM)
1. Services up (names vary by install method):
   - `systemctl status prometheus --no-pager` (if installed as a service)
   - `systemctl status grafana-server --no-pager`
   - if running in containers, prefer: `docker ps`, `docker logs <container>`
2. Local health checks:
   - Prometheus: `curl -sSf http://127.0.0.1:9090/-/healthy`
   - Grafana: `curl -sSf http://127.0.0.1:3000/api/health`
3. Target scrape health:
   - Prometheus UI `/targets` should show **UP** for:
     - `gw-vpn`
     - `mon`
     - `gpu`
     - each `svc-*` long-running VM
   - Optional API quick check:
     - `curl -s http://127.0.0.1:9090/api/v1/targets | head`
4. Spot-check exporter reachability (from `mon`):
   - `curl -sSf http://gw-vpn:9100/metrics | head`
   - `curl -sSf http://gpu:9100/metrics | head`
   - `curl -sSf http://<svc-vm-wg-ip>:9100/metrics | head`

### 5) On `gpu` and any `svc-*` long-running VM
1. node_exporter up:
   - `curl -sSf http://127.0.0.1:9100/metrics | head`
   - or (if systemd-managed): `systemctl status node-exporter --no-pager` (service name may vary)
2. Firewall sanity (if you apply per-VM allowlists):
   - `sudo iptables -S`
   - confirm 9100 is not open broadly to LAN/WAN (restricted source)

### 6) UI access (should be VPN-only)
- Prometheus UI: `http://mon:9090`
- Grafana UI: `http://mon:3000`
- Proxmox UI (VPN-only; restrict to allowlisted sources):
  - `https://<pve-host-or-alias>:8006`

If either UI is reachable from non-VPN networks, treat it as a policy violation and fix firewall/ingress rules.