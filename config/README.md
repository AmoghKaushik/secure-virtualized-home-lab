# Config Templates (Sanitized)

This directory contains **example-only** configuration templates.

## Rules
- Files use placeholders (e.g., `10.0.0.0/24`, `example.internal`, `<CHANGE_ME>`).
- Do not commit real IPs/domains/hostnames, private keys, tokens, or credentials.
- Prefer `*.example` + local real config files that are gitignored.

## Layout
- `wireguard/` — WireGuard examples
- `ssh/` — sshd hardening snippets
- `sysctl/` — kernel/network tuning
- `firewall/` — iptables/nftables examples
