#!/usr/bin/env bash
set -euo pipefail

echo "== iptables version =="
iptables -V || true
echo

echo "== update-alternatives (if available) =="
if command -v update-alternatives >/dev/null 2>&1; then
  update-alternatives --display iptables 2>/dev/null || true
else
  echo "update-alternatives not found"
fi
echo

echo "== nft availability =="
if command -v nft >/dev/null 2>&1; then
  echo "nft present: $(nft --version 2>/dev/null || true)"
else
  echo "nft not found"
fi
echo

echo "== backend hint (iptables-save output header) =="
iptables-save 2>/dev/null | head -n 5 || true