#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="${1:-./snapshots/$(date +%Y%m%d-%H%M%S)}"
mkdir -p "$OUT_DIR"

run() {
  local name="$1"
  shift
  echo "== $name ==" | tee "$OUT_DIR/$name.txt" >/dev/null
  ( "$@" ) >> "$OUT_DIR/$name.txt" 2>&1 || true
}

run uname uname -a
run date date
run uptime uptime

run ip_addr ip addr
run ip_route ip route
run ss_listeners ss -tulpn

run wg_show bash -lc 'command -v wg >/dev/null 2>&1 && wg show || echo "wg not installed"'

run iptables_version iptables -V
run iptables_rules iptables -S
run iptables_save iptables-save

run nft_ruleset bash -lc 'command -v nft >/dev/null 2>&1 && nft list ruleset || echo "nft not installed"'

echo "Snapshot written to: $OUT_DIR"
echo "WARNING: outputs may contain environment identifiers. Sanitize before committing."