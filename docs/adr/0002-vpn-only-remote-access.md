# ADR 0002: VPN-Only Remote Access

## Status
Accepted

## Context
Exposing administrative services (hypervisor UI, SSH, dashboards) directly to the public internet increases attack surface and requires ongoing hardening and vigilance. The lab prioritizes security and controlled access over convenience.

## Decision
All remote access is routed through a VPN (WireGuard). No internal services are intended to be publicly exposed via port forwarding. Administrative access (e.g., SSH) is restricted to the VPN network and uses key-based authentication.

## Consequences
- Greatly reduced public attack surface
- Consistent access model regardless of location
- Additional operational dependency: VPN availability becomes critical for remote administration
- Requires disciplined key management and rotation

## Notes
Public exposure of services, if ever required, should be treated as an exceptional case and documented with a dedicated ADR and threat review.