# Changelog

All notable changes to .floppies will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0] - 2024-12-11

### Added - Awesome Dotfiles Features
- **Programming Fonts Module** (`scripts/install-fonts.sh`)
  - Fira Code, JetBrains Mono, Cascadia Code, Hack, Source Code Pro
  - All fonts with Nerd Font patches (icons and glyphs)
  - Meslo LG Nerd Font for Powerline compatibility
  - Automatic installation on macOS (via Homebrew Cask Fonts)
  - Automatic installation on Linux (downloads from Nerd Fonts releases)
  - Font cache refresh after installation
- **Shell Enhancements Module** (`scripts/install-shell-enhancements.sh`)
  - thefuck - AI-powered command corrector
  - autojump - Smart directory navigation
  - z - Frecent directory jumper
  - direnv - Directory-specific environment variables
  - mosh - Mobile shell for better SSH
  - ncdu - NCurses disk usage analyzer
  - tldr - Simplified man pages
- **Enhanced Dotfiles**
  - `.editorconfig` - Consistent coding styles (VSCode, Vim, IntelliJ, etc.)
  - `.inputrc` - Better readline navigation and completion
  - `.curlrc` - Curl with sane defaults
  - `.wgetrc` - Wget with retry logic and progress bars
  - `.screenrc` - GNU Screen with 256 colors and mouse support
- **Comprehensive Dotfiles Guide** (`docs/DOTFILES_GUIDE.md`)
  - Complete guide to all dotfiles and configurations
  - Shell enhancement usage examples
  - Font configuration for different terminals
  - Color scheme management with base16-shell
  - Advanced SSH config examples
  - Custom function library
  - Synchronization strategies (git, Syncthing)
  - Troubleshooting section

### Enhanced
- Custom installation menu now has 12 options (added fonts and shell enhancements)
- `configure_dotfiles()` now copies all additional dotfiles automatically
- README updated with Programming Fonts, Shell Enhancements, and Enhanced Dotfiles sections
- Better integration with awesome-dotfiles ecosystem

### Documentation
- Added DOTFILES_GUIDE.md with comprehensive dotfiles documentation
- Enhanced README with new features
- Updated installation instructions for new modules

## [1.1.0] - 2024-12-11

### Added - Productivity & AI Tools
- **New Productivity Module** (`scripts/install-productivity.sh`)
  - AI CLI Tools: GitHub Copilot CLI, ChatGPT CLI, Shell-GPT (sgpt), Aider, GPT-Commit
  - Note-Taking: Obsidian, Joplin, Standard Notes, Simplenote, jrnl, glow, pandoc, mdcat
  - Todo Management: todo.txt-cli, Taskwarrior, Taskbook, Todoist CLI, memo, doing
  - Communication: Slack, Telegram, Signal, Discord, Element (Matrix), Microsoft Teams
  - Password Managers: Bitwarden (+ CLI), 1Password (+ CLI), KeePassXC, pass, gopass
  - Terminal Image Viewers: imgcat (iTerm2), viu, chafa, timg, catimg (with sixel support)
  - Self-Hosting Tools: Caddy, Nginx, Syncthing, Tailscale, Portainer
  - Productivity Apps: Alfred, Raycast, Rectangle, Magnet, Toggl, Zeit CLI
- **Comprehensive Productivity Guide** (`docs/PRODUCTIVITY_GUIDE.md`)
  - Complete usage guide for all productivity tools
  - Configuration examples and workflows
  - Self-hosting recommendations
  - Mobile support documentation
- Productivity tools integrated into full installation
- Productivity option (9) added to custom installation menu

### Enhanced
- Terminal emulator support (iTerm2, Warp, Alacritty, Kitty)
- Dynamic color schemes (base16-shell, 256+ themes, random on start)
- Apple Silicon documentation (`docs/APPLE_SILICON.md`)
- Termux setup guide for Android (`docs/TERMUX_SETUP.md`)
- README updated with productivity tools section
- Installation menu now includes productivity tools

### Features
- Image preview in terminal (works with iTerm2, Kitty, Warp, and standard terminals)
- Semi-graphics support in terminal via chafa, timg, and catimg
- AI-powered commit messages and code assistance
- Self-hosting infrastructure ready (Docker, Caddy, Tailscale)
- Complete todo.txt workflow integration
- Secure password management with multiple options
- Cross-platform communication tools

## [1.0.0] - 2024-12-11

### Added
- Initial release of .floppies universal development environment setup
- Main installation script with interactive menu
- OS detection for macOS, Linux (Ubuntu/Debian/RHEL/Arch), Windows (WSL/Git Bash)
- Core essentials installation module
- Development tools installation (Node.js, Python, Ruby, Go, Rust, Java)
- Editor installation (VSCode with 25+ extensions, Vim/Neovim)
- Terminal tools installation (tmux, screen, modern CLI tools)
- Terminal emulators installation (iTerm2, Warp, Alacritty, Kitty)
- Container tools installation (Docker, Kubernetes ecosystem)
- Security tools installation (nmap, wireshark, encryption tools)
- Data science tools installation (Jupyter, NumPy, Pandas, ML libraries)
- Cloud tools installation (AWS CLI, Azure CLI, gcloud, Terraform)
- Comprehensive test suite with 150+ tests
- Test framework with 15+ assertion functions
- Comprehensive dotfiles configuration
  - Bash and Zsh configuration
  - Git configuration with aliases
  - Vim/Neovim configuration
  - tmux configuration
  - VSCode settings
- Automatic backup of existing dotfiles
- Version managers (nvm, pyenv, rbenv, rustup)
- Oh My Zsh with popular plugins
- Starship prompt
- Custom installation option to pick specific components
- Update existing installation option
- Uninstall script with backup restoration
- Quick install one-liner script
- Comprehensive documentation
  - README with features, installation, troubleshooting
  - Platform-specific setup guides
  - FAQ document
  - Apple Silicon guide
  - Termux setup guide
  - Testing documentation
  - MIT License

### GitHub Infrastructure
- GitHub Actions workflows:
  - Weekly dependency update checker
  - CI/CD testing pipeline (Ubuntu & macOS)
  - Security scanning (Gitleaks, dependency review)
- Issue templates (bug report, feature request, documentation, question)
- Pull request template with comprehensive checklist
- SECURITY.md with vulnerability reporting process
- CONTRIBUTING.md with coding standards
- ROADMAP.md with future plans

### Organization & Reusability
- Categories system with reusable installation profiles:
  - web-dev.list
  - data-science.list
  - devops.list
  - security.list
  - minimal.list
- Wiki content structure ready to import
- Architecture documentation

### Platform Support
- macOS (Intel and Apple Silicon M1/M2/M3/M4)
- Ubuntu/Debian (apt)
- Fedora/RHEL/CentOS (dnf/yum)
- Arch/Manjaro (pacman)
- Windows WSL, Git Bash, PowerShell
- Android via Termux
- iOS limited support via iSH

### Developer Experience
- Interactive menu system
- Color-coded output messages
- Idempotent installations (safe to run multiple times)
- Modular script architecture
- Automatic privilege escalation when needed

### Tools Included
- **Languages**: Node.js, Python, Ruby, Go, Rust, Java, TypeScript
- **Shells**: Bash, Zsh, Fish
- **Editors**: VSCode, Vim, Neovim
- **Terminal**: tmux, screen, ripgrep, fd, bat, exa, fzf, htop
- **Containers**: Docker, Docker Compose, kubectl, helm, k9s, minikube
- **Cloud**: AWS CLI, Azure CLI, gcloud CLI, Terraform
- **Security**: nmap, wireshark, hashcat, john, hydra, sqlmap, aircrack-ng
- **Data Science**: Jupyter, NumPy, Pandas, SciPy, TensorFlow, PyTorch
- **Version Control**: Git, Git LFS
- **Package Managers**: Homebrew, Chocolatey, Scoop, npm, pip, gem, cargo

### VSCode Extensions
- GitHub Copilot & Copilot Chat
- Remote Development (SSH, WSL, Containers)
- Language support (Python, C/C++, Go, Rust, Ruby, PHP, Java)
- Docker & Kubernetes tools
- GitLens
- Prettier, ESLint
- Jupyter
- Terraform
- Path IntelliSense
- Auto Rename Tag
- Tailwind CSS
- React snippets
- Spell checker

## [Unreleased]

### Planned Features
- [ ] Android Termux support
- [ ] iOS iSH support
- [ ] Configuration profiles (web-dev, data-science, devops, etc.)
- [ ] dotfiles synchronization across machines
- [ ] Plugin system for custom extensions
- [ ] GUI installer for Windows
- [ ] Automated testing on multiple platforms
- [ ] Update checker and notification system
- [ ] Installation progress bar
- [ ] Parallel package installation
- [ ] Chocolatey/Scoop auto-detection and installation
- [ ] Package version pinning
- [ ] Rollback functionality
- [ ] Export/import configuration
- [ ] Docker image with .floppies pre-installed
- [ ] More language support (Haskell, Elixir, Scala, etc.)
- [ ] IDE support (IntelliJ IDEA, Eclipse, etc.)
- [ ] Shell function library
- [ ] Git hooks setup
- [ ] SSH key management
- [ ] GPG key management

### Known Issues
- Some VSCode extensions may fail to install in remote SSH sessions
- Docker group changes require logout/login on Linux
- Homebrew path configuration may need manual sourcing on first install

---

## How to Update

To update to the latest version:

```bash
cd .floppies
git pull origin main
./install.sh
# Select option 4: Update Existing Installation
```

## Version History

- **1.0.0** (2024-12-11): Initial release

---

For more information, see [README.md](README.md).
