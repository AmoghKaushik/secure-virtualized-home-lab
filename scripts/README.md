# Scripts (Sanitized)

Small helper scripts for auditing and collecting diagnostics.

## Rules
- Scripts must be safe to run (read-only by default).
- Do not embed secrets, tokens, keys, or real internal identifiers.
- Output may contain environment identifiers; do not commit raw outputs unless sanitized.

## Scripts
- `collect-snapshot.sh` — collect basic system/network/firewall state into a timestamped folder
- `check-iptables-backend.sh` — show whether iptables is legacy vs nf_tables and related info