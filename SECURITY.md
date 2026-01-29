# Security Policy

## Purpose
This repository documents a personal home lab used for learning and experimentation.
It is intentionally sanitized and does not contain production credentials, secrets,
or environment-specific identifiers.

## What This Repository Contains
- Architecture documentation
- Design decisions and trade-offs
- Sanitized configuration examples (`.example` files only)
- Templates and patterns for infrastructure setup

## What This Repository Does NOT Contain
- Real IP addresses, domains, or hostnames
- VPN private keys or live WireGuard configurations
- SSH private keys or authorized_keys files
- Tokens, passwords, or API keys
- Full system configuration dumps

## Configuration Files
Any configuration files present are provided as examples only and use placeholder
values such as:
- `10.0.0.0/24`
- `example.internal`
- `<REDACTED>` or `<PLACEHOLDER>`

They are not intended to be deployed directly without modification.

## Responsible Use
If you adapt patterns or examples from this repository:
- Generate your own keys and secrets
- Use your own addressing scheme
- Review security implications in your own environment

No security issues related to live systems should be reported against this repository,
as it does not operate any public services.
