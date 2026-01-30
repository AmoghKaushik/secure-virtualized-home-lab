# Firewall templates (iptables frontend)

This lab documents firewall policy using the **iptables frontend**.

Backend differs by node:
- Proxmox host: `iptables (legacy)`
- VMs: `iptables (nf_tables)` (iptables-nft)

The rules in this directory are templates in `iptables-save` format and are sanitized.
Replace placeholders for your environment and do not commit real identifiers.
