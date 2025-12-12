# Contributing to .floppies

Thank you for considering contributing to .floppies! This document provides guidelines and instructions for contributing.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Coding Guidelines](#coding-guidelines)
- [Submitting Changes](#submitting-changes)
- [Testing](#testing)

## Code of Conduct

This project follows a simple code of conduct:

- Be respectful and inclusive
- Focus on constructive feedback
- Help others learn and grow
- Respect different perspectives and experiences

## How Can I Contribute?

### Reporting Bugs

- Use the bug report template
- Search existing issues first
- Include OS, version, and reproduction steps
- Provide error messages and logs

### Suggesting Features

- Use the feature request template
- Explain the use case and benefits
- Consider cross-platform implications
- Be open to alternative solutions

### Improving Documentation

- Fix typos and grammar
- Add missing information
- Clarify confusing sections
- Add examples and use cases

### Contributing Code

- Fix bugs
- Add new platform support
- Add new tools/packages
- Improve existing functionality
- Enhance error handling

## Development Setup

### Prerequisites

- Bash 4.0 or later
- Git
- Text editor or IDE
- Access to target platforms for testing

### Getting Started

```bash
# Fork the repository on GitHub
# Clone your fork
git clone https://github.com/YOUR_USERNAME/.floppies.git
cd .floppies

# Create a feature branch
git checkout -b feature/your-feature-name

# Make your changes
# Test your changes
./install.sh

# Commit your changes
git add .
git commit -m "Description of changes"

# Push to your fork
git push origin feature/your-feature-name

# Create a Pull Request on GitHub
```

## Coding Guidelines

### Shell Script Style

1. **Use Bash**: Scripts should use `#!/usr/bin/env bash`
2. **Error Handling**: Use `set -e` at the top of scripts
3. **Functions**: Use clear, descriptive function names
4. **Comments**: Add comments for complex logic
5. **Variables**: Use UPPERCASE for constants, lowercase for locals
6. **Quotes**: Always quote variables: `"$variable"`

### Example

```bash
#!/usr/bin/env bash

set -e

# Constants
readonly INSTALL_DIR="/usr/local/bin"

# Function documentation
install_package() {
    local package_name=$1
    
    log_info "Installing $package_name..."
    
    if command -v "$package_name" &> /dev/null; then
        log_info "$package_name already installed"
        return 0
    fi
    
    # Installation logic here
}
```

### Logging

Use the logging functions consistently:

```bash
log_info "Informational message"
log_success "Success message"
log_warning "Warning message"
log_error "Error message"
```

### Cross-Platform Compatibility

- Test on multiple platforms (macOS, Linux, Windows WSL)
- Use platform detection: `case "$OS" in ...`
- Handle platform-specific package managers
- Avoid hardcoding paths
- Check for command existence before using

### Idempotency

Scripts should be idempotent (safe to run multiple times):

```bash
# Good - checks before installing
if ! command -v node &> /dev/null; then
    install_node
fi

# Bad - always tries to install
install_node
```

### Backups

Always backup before modifying files:

```bash
if [ -f "$HOME/.bashrc" ]; then
    cp "$HOME/.bashrc" "$BACKUP_DIR/.bashrc"
fi
```

## Submitting Changes

### Pull Request Process

1. **Update Documentation**: Update README, FAQ, or other docs if needed
2. **Add Tests**: Add or update tests if applicable
3. **Check Syntax**: Run `bash -n script.sh` on all modified scripts
4. **Test Thoroughly**: Test on relevant platforms
5. **Update CHANGELOG**: Add entry describing your changes
6. **Create PR**: Use a clear, descriptive title and description

### Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Performance improvement
- [ ] Other (describe)

## Platforms Tested
- [ ] macOS
- [ ] Ubuntu/Debian
- [ ] Fedora/RHEL
- [ ] Arch Linux
- [ ] Windows WSL

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] Tested on relevant platforms
- [ ] No hardcoded credentials
```

## Testing

### Manual Testing

Test your changes on actual systems:

```bash
# Syntax check
bash -n install.sh
bash -n scripts/*.sh

# Test installation
./install.sh

# Verify installation
./verify.sh
```

### Platform Testing

- **macOS**: Test on Intel and Apple Silicon if possible
- **Linux**: Test on at least Ubuntu and one other distribution
- **Windows**: Test in WSL

### Test Cases

Consider these scenarios:

1. Fresh installation
2. Update existing installation
3. Custom installation with specific components
4. Installation on different OS versions
5. Installation with/without sudo access

## Adding New Features

### Adding a New Tool

1. Determine which module it belongs to (dev-tools, editors, etc.)
2. Add installation logic to the appropriate `scripts/install-*.sh` file
3. Update documentation (README, FAQ)
4. Add to verification script if appropriate
5. Test on multiple platforms

### Adding a New Platform

1. Add OS detection to `install.sh`
2. Create new installation script `scripts/install-newos.sh`
3. Implement core functions for the platform
4. Update documentation
5. Add to CI/CD testing

### Adding New Configuration

1. Add to `scripts/configure-dotfiles.sh`
2. Create backup of existing config
3. Generate new config file
4. Document the configuration
5. Test backup/restore functionality

## Style Checkers

Use shellcheck to validate scripts:

```bash
# Install shellcheck
# macOS: brew install shellcheck
# Ubuntu: sudo apt install shellcheck

# Run shellcheck
shellcheck install.sh
shellcheck scripts/*.sh
```

## Documentation Standards

- Use clear, concise language
- Include code examples
- Add troubleshooting tips
- Keep README updated
- Document breaking changes
- Update CHANGELOG

## Questions?

If you have questions about contributing:

1. Check existing documentation
2. Search closed issues and PRs
3. Ask in a new issue with the "question" label

## Recognition

Contributors are recognized in:

- README contributors section (if added)
- Release notes
- Git commit history

Thank you for contributing to .floppies! 🎉
