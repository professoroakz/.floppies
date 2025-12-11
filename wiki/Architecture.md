# .floppies Architecture

This document describes the technical architecture and design decisions behind .floppies.

## Overview

.floppies is a bash-based installation orchestrator that provides cross-platform development environment setup through:

- **Modular script architecture** - Independent, composable installation modules
- **OS detection and adaptation** - Platform-specific package managers and tools
- **Idempotent execution** - Safe to run multiple times
- **Configuration backup** - Automatic backup before changes
- **Category-based profiles** - Reusable tool collections

## Directory Structure

```
.floppies/
├── .github/              # GitHub infrastructure
│   ├── ISSUE_TEMPLATE/   # Issue forms
│   ├── workflows/        # GitHub Actions
│   └── PULL_REQUEST_TEMPLATE.md
├── categories/           # Installation profiles
│   ├── web-dev.list     # Web development
│   ├── data-science.list # Data science
│   ├── devops.list      # DevOps tools
│   ├── security.list    # Security tools
│   └── minimal.list     # Minimal setup
├── docs/                # Documentation
│   ├── FAQ.md           # Frequently asked questions
│   └── PLATFORM_SETUP.md # Platform guides
├── dotfiles/            # Example configurations
│   ├── bash_aliases.example
│   └── starship.toml.example
├── scripts/             # Installation modules
│   ├── install-*.sh     # Platform/feature installers
│   ├── configure-dotfiles.sh
│   └── uninstall.sh
├── wiki/                # Wiki content
├── install.sh           # Main installer
├── quick-install.sh     # One-liner installer
└── verify.sh            # Post-install verification
```

## Core Components

### 1. Main Installer (`install.sh`)

**Purpose**: Entry point and orchestration

**Responsibilities**:
- OS detection
- Menu system
- Module coordination
- Error handling
- Logging

**Key Functions**:
```bash
detect_os()           # Determine operating system
show_menu()           # Display installation options
install_core()        # Install core essentials
install_full()        # Full installation
custom_installation() # Custom component selection
```

**Design Pattern**: Command pattern with menu-driven interface

### 2. Installation Modules (`scripts/`)

**Purpose**: Platform and feature-specific installation logic

**Modules**:
- `install-macos.sh` - macOS (Homebrew)
- `install-linux.sh` - Linux (apt/dnf/pacman)
- `install-windows.sh` - Windows (WSL/Chocolatey/Scoop)
- `install-dev-tools.sh` - Languages and runtimes
- `install-editors.sh` - VSCode, Vim
- `install-terminal.sh` - Shell and CLI tools
- `install-containers.sh` - Docker, Kubernetes
- `install-cloud.sh` - Cloud CLIs
- `install-security.sh` - Security tools
- `install-datascience.sh` - Data science stack

**Design Pattern**: Strategy pattern - swap implementations based on OS

### 3. Configuration System (`configure-dotfiles.sh`)

**Purpose**: Setup shell, editor, and tool configurations

**Features**:
- Automatic backup to `~/.dotfiles_backup_*`
- Template-based configuration generation
- User-specific customization prompts
- Version control-friendly outputs

**Configurations**:
- `.bashrc`, `.zshrc` - Shell configs
- `.vimrc` - Vim configuration
- `.tmux.conf` - Tmux configuration
- `.gitconfig` - Git configuration
- VSCode `settings.json`

### 4. Verification System (`verify.sh`)

**Purpose**: Post-installation validation

**Checks**:
- Command availability
- File existence
- Directory structure
- Configuration correctness

**Output**: Pass/fail report with recommendations

### 5. Categories System (`categories/`)

**Purpose**: Reusable installation profiles

**Format**:
```
# Category: Name
# Description: Details

tool:version    # With version
npm:package     # npm packages
pip:package     # pip packages
vscode:ext      # VSCode extensions
```

**Benefits**:
- Shareable profiles
- Custom combinations
- Version control
- Remote loading (future)

## Design Principles

### 1. Idempotency

All operations are idempotent - safe to run multiple times:

```bash
# Check before installing
if ! command -v node &> /dev/null; then
    install_node
fi
```

### 2. Defensive Programming

- Check preconditions
- Validate inputs
- Handle errors gracefully
- Provide fallbacks

```bash
# Always check before using
if [ -f "$file" ]; then
    backup_file "$file"
fi
```

### 3. Fail-Safe Defaults

- Backup before modifications
- Prompt for destructive actions
- Skip on errors (continue installation)
- Log failures for review

### 4. Platform Abstraction

```bash
case "$OS" in
    macos)
        brew install package
        ;;
    ubuntu|debian)
        apt-get install -y package
        ;;
esac
```

### 5. Separation of Concerns

- Installation logic separate from configuration
- Platform-specific code isolated
- Reusable functions
- Minimal coupling

## Data Flow

```
User
  ↓
install.sh (main)
  ↓
OS Detection
  ↓
Menu Selection
  ↓
Installation Module(s)
  ↓
Package Managers
  ↓
Configuration
  ↓
Verification
  ↓
Report
```

## State Management

### Installation State

- **No persistent state** - Each run is independent
- **Package manager cache** - OS-level caching
- **Backup directory** - Timestamp-based backups

### Configuration State

- **Dotfiles** - User home directory
- **Backups** - `~/.dotfiles_backup_YYYYMMDD_HHMMSS/`
- **Version managers** - `~/.nvm`, `~/.pyenv`, etc.

## Error Handling

### Strategy

1. **Fail gracefully** - Log and continue
2. **Informative messages** - Explain what went wrong
3. **Recovery suggestions** - How to fix manually
4. **No partial state** - Atomic operations where possible

### Implementation

```bash
set -e  # Exit on error (at script level)

# Per-operation error handling
command || {
    log_error "Command failed"
    return 1
}

# Optional operations
optional_command || log_warning "Optional feature unavailable"
```

## Security Considerations

### Input Validation

- No user input directly in commands
- Quote all variables
- Validate file paths
- Check command existence

### Privilege Escalation

- Run as regular user
- Prompt for sudo only when needed
- Minimize sudo operations
- Document sudo requirements

### Package Sources

- Use official repositories only
- Verify package signatures
- HTTPS for downloads
- No hardcoded secrets

## Performance Optimization

### Techniques

1. **Parallel installations** (where safe)
2. **Cached package lists**
3. **Skip installed packages**
4. **Minimal dependencies**
5. **Efficient OS detection**

### Trade-offs

- **Simplicity over speed** - Readable bash over complex optimizations
- **Reliability over performance** - Sequential when order matters
- **Cross-platform over platform-specific** - Works everywhere

## Extensibility

### Adding New Platforms

1. Add OS detection in `install.sh`
2. Create `scripts/install-newos.sh`
3. Implement required functions
4. Test thoroughly
5. Document platform-specific notes

### Adding New Tools

1. Identify appropriate module
2. Add installation logic
3. Add to verification script
4. Update documentation
5. Test on multiple platforms

### Adding New Categories

1. Create `categories/name.list`
2. Define tools and versions
3. Document use case
4. Test installation
5. Add to README

## Testing Strategy

### Manual Testing

- Fresh OS installations
- Multiple platforms
- Different components
- Upgrade scenarios

### Automated Testing

- Syntax checking (bash -n)
- Shellcheck linting
- GitHub Actions CI
- Platform-specific runners

### Validation

- Verification script
- Command availability
- Configuration correctness
- Documentation accuracy

## Future Architecture

### Planned Enhancements

1. **Plugin system** - Custom extensions
2. **Remote profiles** - Load from URLs
3. **Dependency resolution** - Smart conflict handling
4. **Parallel execution** - Faster installations
5. **GUI interface** - Graphical installer

### Considerations

- Maintain backwards compatibility
- Keep bash as base (portable)
- Optional advanced features
- Progressive enhancement

## Dependencies

### Runtime Dependencies

- **Bash 4.0+** - Shell interpreter
- **curl/wget** - Download tools
- **git** - Version control

### Platform Dependencies

- **macOS**: Xcode Command Line Tools
- **Linux**: build-essential (or equivalent)
- **Windows**: WSL or Git Bash

## Versioning

### Strategy

- Semantic Versioning (SemVer)
- Major: Breaking changes
- Minor: New features
- Patch: Bug fixes

### Compatibility

- Maintain backwards compatibility in minor versions
- Document breaking changes
- Provide migration guides
- Deprecate gradually

## Monitoring & Maintenance

### Automated Checks

- **Weekly dependency updates** (GitHub Actions)
- **Security scanning** (Gitleaks)
- **CI/CD testing** (Multiple platforms)

### Manual Reviews

- Quarterly documentation review
- Annual architecture review
- User feedback integration
- Performance profiling

## References

- [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- [Bash Reference Manual](https://www.gnu.org/software/bash/manual/)
- [Cross-Platform Shell Scripts](https://github.com/dylanaraps/pure-bash-bible)

---

**Last Updated**: 2024-12-11  
**Version**: 1.1  
**Author**: professoroakz
