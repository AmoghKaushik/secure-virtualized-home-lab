# VM roles and access paths

High-level view of VM roles (gateway, monitoring, GPU, service VMs) and how access/metrics flow through the lab.

```mermaid
flowchart LR
  Client["Admin Client<br/>(VPN connected)"]

  %% Keep host separate; short title prevents clipping in some renderers
  subgraph Host["Virtualization Host"]
    PVE["Proxmox VE (Control Plane)<br/>VM lifecycle + storage"]
  end

  %% Main VM grouping (covers current + future)
  subgraph VMs["Lab VMs (Current + Future)"]
    GW["gw-vpn (Gateway VM)<br/>WireGuard + routing + choke point"]
    GPU["gpu (GPU VM(s))<br/>Direct GPU workloads"]

    %% Monitoring (explicit identity)
    MON["mon (Monitoring VM)<br/>Prometheus/Grafana etc."]

    %% Collective group for all service VMs (now and later)
    SVC_ALL["svc-* (Service VM(s) group)<br/>All internal services (current + future)<br/>e.g., apps, storage, utilities, experiments"]
  end

  %% Access paths (admin reachability)
  Client -->|VPN| GW
  Client -->|VPN| GPU

  %% Admin plane (control plane access)
  GW -->|"Admin access (allowlist)"| PVE

  %% Service reachability (from VPN entry point)
  GW -->|"Service access (allowlist)"| SVC_ALL
  GW -->|"Dashboards/UI access (allowlist)"| MON

  %% Observability model (Prometheus pulls via exporters)
  MON -->|"scrape metrics (exporters)"| GW
  MON -->|"scrape metrics (exporters)"| SVC_ALL
  MON -->|"scrape metrics (exporters)"| GPU

  %% Notes (kept minimal to avoid layout distortion)
  classDef note fill:#fff,stroke:#999,stroke-dasharray: 3 3,color:#111;

  N1["Gateway VM is the intended remote entry point<br/>(centralizes access control)"]:::note
  N2["Monitoring pulls metrics internally;<br/>services do not need WAN exposure"]:::note
  N3["GPU VM(s) isolated to reduce blast radius<br/>of drivers/experiments"]:::note
  N4["svc-* represents a group<br/>of multiple current and future service VMs"]:::note

  GW -.-> N1
  MON -.-> N2
  GPU -.-> N3
  SVC_ALL -.-> N4
```