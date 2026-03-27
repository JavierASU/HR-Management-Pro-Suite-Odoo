# Security Policy

## Supported Versions

| Version    | Supported          |
|------------|-------------------|
| 17.0.x.x.x | :white_check_mark: |
| < 17.0     | :x:                |

## Reporting a Vulnerability

If you discover a security vulnerability, please report it responsibly:

1. **Do not** open a public issue
2. Email the maintainer directly or use GitHub's private vulnerability reporting
3. Include steps to reproduce and potential impact
4. Allow reasonable time for a fix before disclosure

## Security Model

This module implements three security levels:

- **HR Pro User**: Can only access their own requests
- **HR Pro Manager**: Can access all requests, approve/reject
- **HR Pro Admin**: Full access including delete operations

All access is controlled through Odoo's built-in `ir.rule` record rules and `res.groups` security groups.
