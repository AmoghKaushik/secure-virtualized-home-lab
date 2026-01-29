# Architecture Overview

This home lab is designed around **virtualization-first isolation**: services run inside dedicated virtual machines, and container workloads (when used) run inside those VMs. The system prioritizes security boundaries, controlled change, and operational reliability over convenience.

## Goals
- Isolate workloads to reduce blast radius
- Keep remote access constrained to a single, auditable path
- Make changes reversible (snapshots, staged rollout)
- Document decisions and trade-offs for repeatability and learning

## Layers

### Host Layer (Virtualization)
- **Hypervisor:** Proxmox VE (KVM/QEMU)
- The host is treated as a **control plane** (VM lifecycle, storage, networking).
- The host is not intended to run application services directly.

### VM Layer (Service Isolation)
VMs are used to enforce stronger boundaries than containers alone:
- Infrastructure VM(s) for networking and remote access (VPN gateway)
- Service VM(s) for Dockerized apps and internal services
- GPU passthrough VM(s) for workloads requiring direct hardware access

### Container Layer (Inside Service VMs)
Containers are used for:
- Packaging and repeatable service deployment
- Clean upgrades/rollbacks at the service level
- Separation of app components within a VM boundary

## Trust Boundaries
The design assumes:
- **WAN is hostile**
- **LAN is semi-trusted**
- **VPN is the primary trusted entry point**

Key constraints:
- No direct exposure of internal services to the public internet
- Remote administration occurs over VPN using key-based authentication
- Internal services are reachable only from controlled networks (e.g., VPN subnet and/or specific internal segments)

## GPU Passthrough Boundary (When Used)
GPU passthrough workloads are isolated into dedicated VMs to:
- Avoid coupling host stability to guest drivers
- Reduce the blast radius of GPU/driver experimentation
- Keep the host focused on stability and management

## Change Management Model
- Prefer staged changes and small diffs
- Take snapshots before high-risk changes
- Maintain short runbooks for common operations and recovery