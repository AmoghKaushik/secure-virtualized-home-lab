# Networking Model

This document describes the networking approach at a design level. Concrete identifiers (real subnets, domains, hostnames) are intentionally replaced with placeholders.

## Principles
- **Single NAT** to avoid double-NAT issues and simplify routing/debugging
- **VPN-first access** for remote management and service access
- **Default-deny mindset** for inbound traffic; explicit allowlists
- Keep the hypervisor management surface minimally exposed

## High-Level Topology (Conceptual)
- Edge router provides internet connectivity and NAT
- Hypervisor host provides virtualization and internal switching/bridging
- An infrastructure VM provides WireGuard VPN access and (when needed) controlled routing between VPN and internal networks
- Service VMs run application workloads; they are not directly exposed to WAN

## VPN-Only Remote Access
Remote access is designed around:
- WireGuard as the entry point
- Key-based authentication (no password-based remote entry)
- Access scoped to only what is required

This reduces:
- Public attack surface
- Accidental exposure of services
- Reliance on port-forwarded management endpoints

## Addressing (Placeholders)
Examples used in documentation:
- VPN subnet: `10.0.0.0/24`
- Internal LAN: `192.168.0.0/24`
- Internal domains: `example.internal`

These values are placeholders and do not represent the actual environment.

## East–West Traffic (VM-to-VM)
VM-to-VM communication is allowed only as needed for:
- Monitoring and metrics scraping
- Internal service dependencies
- Administrative access over VPN

Where possible:
- Limit by source network (e.g., VPN subnet) rather than “anywhere”
- Prefer explicit service ports and explicit source allowlists

## Future Segmentation (Optional)
If the environment grows, segmentation can be extended with:
- Dedicated VLANs for management, services, and untrusted devices
- A managed switch and VLAN-aware bridges
- Firewall policies per segment

This repository documents the model and decisions; it does not publish a full deployable VLAN configuration.