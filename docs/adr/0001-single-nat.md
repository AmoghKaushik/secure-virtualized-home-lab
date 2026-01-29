# ADR 0001: Single NAT Architecture

## Status
Accepted

## Context
Double NAT commonly increases operational friction: it complicates inbound/outbound reachability, makes debugging connectivity harder, and can break or degrade peer-to-peer or VPN scenarios. The lab is intended to support reliable remote access and predictable routing.

## Decision
Use a single NAT boundary at the primary edge router. Internal networks behind the virtualization host and service VMs are designed assuming there is only one upstream NAT device.

## Consequences
- Simplified routing and troubleshooting
- Fewer edge cases for VPN connectivity and service reachability
- Clearer responsibility split: edge router handles NAT; lab handles internal segmentation and firewall policy

## Notes
This repository documents the design decision, not the exact upstream device configuration.