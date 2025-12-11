# Security Policy

## Supported Versions

We release patches for security vulnerabilities for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |

## Reporting a Vulnerability

We take the security of .floppies seriously. If you discover a security vulnerability, please follow these steps:

### 1. **DO NOT** Create a Public Issue

Please do not report security vulnerabilities through public GitHub issues.

### 2. Report Privately

Instead, please report them via one of these methods:

- **GitHub Security Advisories**: Use the [Security tab](https://github.com/professoroakz/.floppies/security/advisories/new) to report privately
- **Email**: Send details to the repository owner (check GitHub profile for contact)

### 3. Include These Details

Please include as much of the following information as possible:

- Type of vulnerability
- Step-by-step instructions to reproduce
- Affected versions
- Potential impact
- Suggested fix (if any)
- Your contact information

### 4. What to Expect

- **Acknowledgment**: We'll acknowledge receipt within 48 hours
- **Updates**: We'll keep you informed of progress
- **Timeline**: We aim to release a fix within 14 days for critical issues
- **Credit**: We'll credit you in the release notes (unless you prefer otherwise)

## Security Best Practices

When using .floppies:

### Installation Security

1. **Verify Source**: Always clone from the official repository
2. **Review Scripts**: Inspect scripts before running them
3. **Use HTTPS**: Clone using HTTPS, not unverified HTTP sources
4. **Check Signatures**: Verify commit signatures when available

### Usage Security

1. **Keep Updated**: Regularly update .floppies and installed tools
2. **Review Changes**: Review changes in updates before applying
3. **Backup First**: Always backup your configurations before running updates
4. **Minimal Privileges**: Don't run the installer as root/sudo (it will prompt when needed)

### Configuration Security

1. **Protect Credentials**: Never commit API keys, tokens, or passwords
2. **Use SSH Keys**: Prefer SSH keys over password authentication
3. **Enable 2FA**: Use two-factor authentication for services
4. **Secure Dotfiles**: Review dotfile permissions (should not be world-writable)

## Known Security Considerations

### Script Execution

- .floppies runs shell scripts that modify your system
- All scripts are provided as-is and should be reviewed before execution
- Scripts may download and install third-party software
- Scripts may modify system configurations and dotfiles

### Package Installation

- .floppies installs packages from official repositories
- Package security depends on the upstream package maintainers
- Always use official package repositories when available

### Automatic Backups

- .floppies backs up existing dotfiles before modification
- Backups are stored in `~/.dotfiles_backup_*` directories
- It's recommended to maintain your own additional backups

## Security Features

.floppies includes several security features:

1. **Automatic Backups**: Configurations backed up before changes
2. **Idempotent**: Safe to run multiple times
3. **Privilege Escalation**: Only prompts for sudo when necessary
4. **No Hardcoded Secrets**: No credentials embedded in code
5. **Syntax Validation**: All scripts validated before release

## Security Tools Included

.floppies can install various security tools:

- GnuPG for encryption
- OpenSSH for secure connections
- Password managers (pass)
- Network security tools (nmap, wireshark)
- Penetration testing tools (optional)

## Responsible Disclosure

We follow responsible disclosure practices:

1. We'll work with you to understand and reproduce the issue
2. We'll develop and test a fix
3. We'll release the fix and publish a security advisory
4. We'll credit the reporter (with permission)

## Security Updates

- Security updates are released as soon as possible
- Critical vulnerabilities receive immediate attention
- Security advisories are published through GitHub Security Advisories
- Users are notified through GitHub releases and README updates

## Additional Resources

- [GitHub Security Best Practices](https://docs.github.com/en/code-security)
- [OWASP Secure Coding Practices](https://owasp.org/www-project-secure-coding-practices-quick-reference-guide/)
- [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks/)

## Questions?

If you have questions about security that aren't covered here:

1. Check the [FAQ](docs/FAQ.md)
2. Search existing [Issues](https://github.com/professoroakz/.floppies/issues)
3. Create a new issue (for non-sensitive questions)

Thank you for helping keep .floppies and our users secure!
