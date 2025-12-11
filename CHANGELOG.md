# Changelog

All notable changes to .floppies will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-12-11

### Added
- Initial release of .floppies universal development environment setup
- Main installation script with interactive menu
- OS detection for macOS, Linux (Ubuntu/Debian/RHEL/Arch), Windows (WSL/Git Bash)
- Core essentials installation module
- Development tools installation (Node.js, Python, Ruby, Go, Rust, Java)
- Editor installation (VSCode with 25+ extensions, Vim/Neovim)
- Terminal tools installation (tmux, screen, modern CLI tools)
- Container tools installation (Docker, Kubernetes ecosystem)
- Security tools installation (nmap, wireshark, encryption tools)
- Data science tools installation (Jupyter, NumPy, Pandas, ML libraries)
- Cloud tools installation (AWS CLI, Azure CLI, gcloud, Terraform)
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
  - MIT License

### Platform Support
- macOS (Intel and Apple Silicon M1/M2/M3)
- Ubuntu/Debian (apt)
- Fedora/RHEL/CentOS (dnf/yum)
- Arch/Manjaro (pacman)
- Windows WSL, Git Bash, PowerShell

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
