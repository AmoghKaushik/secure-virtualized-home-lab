# ADR 0004: Isolate GPU Workloads into Dedicated VMs

## Status
Accepted

## Context
GPU drivers and passthrough configurations can be disruptive when misconfigured. Tying GPU experimentation to the host or to unrelated services increases risk of downtime and complicates recovery.

## Decision
GPU-intensive workloads run in dedicated VMs with direct GPU passthrough where required. The virtualization host remains focused on stability and management responsibilities.

## Consequences
- Reduced blast radius for GPU/driver changes
- Easier rollback (VM snapshot) when experimenting
- Clear separation between infrastructure services and performance workloads
- Requires careful passthrough configuration and device assignment discipline

## Notes
This ADR describes the boundary, not the exact hardware identifiers or device mappings.