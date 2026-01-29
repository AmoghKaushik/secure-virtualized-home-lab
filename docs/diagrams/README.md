# Diagrams

This directory contains sanitized diagrams describing the homelab design.

## Format
Diagrams are stored as Mermaid source files (`.mmd`) to keep them:
- diff-friendly
- easy to review in PRs
- simple to keep sanitized

## Viewing
GitHub renders Mermaid in Markdown files. For `.mmd` source files, you can:
- copy/paste the content into the Mermaid Live Editor, or
- use a VS Code Mermaid extension to preview.

## Exporting (optional)
If you want PNG/SVG exports, generate them locally and commit exports only if they do not
introduce environment-specific identifiers. Source files are preferred.

## Sanitization
Do not include:
- real IP addresses, domains, hostnames
- keys, tokens, or credentials
Use placeholders like `10.0.0.0/24` and `example.internal`.