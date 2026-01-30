# Diagrams

This directory contains sanitized diagrams describing the homelab design.

## Format
Diagrams are stored as Markdown files (`.md`) containing Mermaid code blocks to keep them:
- diff-friendly
- easy to review in PRs
- simple to keep sanitized

## Viewing
- GitHub renders Mermaid inside Markdown files automatically.
- In VS Code, use a Mermaid/Markdown preview extension if needed.
- You can also paste Mermaid blocks into the Mermaid Live Editor.

## Exporting (optional)
If you want PNG/SVG exports, generate them locally and commit exports only if they do not
introduce environment-specific identifiers. Source files are preferred.

## Sanitization
Do not include:
- real IP addresses, domains, hostnames
- keys, tokens, or credentials
Use placeholders like `10.0.0.0/24` and `example.internal`.