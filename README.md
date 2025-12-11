# .floppies 💾

**The Universal Development Environment Setup**

One script to install them all! A comprehensive, cross-platform development environment setup tool that works on macOS, Linux (Ubuntu/Debian/RHEL/Arch), Windows (WSL/Git Bash), and more.

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/professoroakz/.floppies.git
cd .floppies

# Run the installer
chmod +x install.sh
./install.sh
```

That's it! The installer will guide you through the setup process.

## ✨ Features

### 🎯 Core Essentials
- **Package Managers**: Homebrew (macOS), apt, yum/dnf, pacman, Chocolatey, Scoop
- **Version Control**: Git, Git LFS
- **Essential Tools**: curl, wget, SSH, GnuPG
- **Modern Shell**: Bash, Zsh, Fish
- **GNU Utilities**: coreutils, findutils, grep, sed

### 💻 Development Tools
- **Languages**: Node.js, Python, Ruby, Go, Rust, Java
- **Version Managers**: nvm, pyenv, rbenv, rustup
- **Package Managers**: npm, yarn, pnpm, pip, pipenv, poetry, gem, cargo
- **Build Tools**: make, cmake, gcc, g++
- **Databases**: PostgreSQL, MySQL, Redis, MongoDB

### 📝 Editors & IDEs
- **Visual Studio Code** with 25+ essential extensions
  - GitHub Copilot
  - Remote Development (SSH, WSL, Containers)
  - Language support (Python, JavaScript, Go, Rust, etc.)
  - Docker, Kubernetes tools
  - Prettier, ESLint, and more
- **Vim/Neovim** with vim-plug plugin manager
- Pre-configured dotfiles for both

### 🖥️ Terminal Tools
- **Multiplexers**: tmux, screen
- **Modern CLI Tools**: 
  - `ripgrep` (faster grep)
  - `fd` (faster find)
  - `bat` (better cat)
  - `exa` (modern ls)
  - `fzf` (fuzzy finder)
  - `htop` (process viewer)
  - `httpie` (HTTP client)
- **Shell Enhancements**:
  - Oh My Zsh with plugins
  - Starship prompt
  - Syntax highlighting
  - Auto-suggestions

### 🐳 Container & Orchestration
- **Docker**: Docker Engine, Docker Compose
- **Kubernetes**: kubectl, helm, k9s, minikube
- Full container development workflow

### ☁️ Cloud Tools
- **AWS**: AWS CLI
- **Azure**: Azure CLI
- **Google Cloud**: gcloud CLI
- **Infrastructure as Code**: Terraform

### 🔒 Security Tools
- Network tools: nmap, netcat, socat, tcpdump, Wireshark
- Password cracking: hashcat, john, hydra
- Security testing: sqlmap, aircrack-ng
- Encryption: GnuPG, pass (password manager)

### 📊 Data Science (Optional)
- Jupyter Lab/Notebook
- Scientific computing: NumPy, Pandas, SciPy
- Machine Learning: scikit-learn, TensorFlow, PyTorch
- Visualization: Matplotlib, Seaborn, Plotly
- R environment

## 🗂️ Installation Profiles

.floppies now supports categorized installations for specific use cases:

- **web-dev** - Web development stack (Node, React, Vue, Angular, etc.)
- **data-science** - Data science tools (Jupyter, Pandas, TensorFlow, etc.)
- **devops** - DevOps tools (Docker, Kubernetes, Terraform, etc.)
- **security** - Security and pentesting tools
- **minimal** - Just the essentials

See [categories/](categories/) for complete lists and custom profile creation.

## 📋 Installation Options

When you run `./install.sh`, you'll see a menu:

1. **Full Installation** (Recommended)
   - Installs everything: core tools, dev tools, editors, terminal tools, containers, cloud tools
   - Configures dotfiles
   - Perfect for setting up a new machine

2. **Core Essentials Only**
   - Just the basics: Git, package managers, essential utilities
   - Good for minimal setups or servers

3. **Custom Installation**
   - Pick and choose components:
     - Development Tools
     - Editors (VSCode, Vim)
     - Terminal Tools
     - Container Tools
     - Security Tools
     - Data Science Tools
     - Cloud Tools
     - Dotfiles Configuration

4. **Update Existing Installation**
   - Updates .floppies and re-runs installation
   - Keeps your environment current

5. **Uninstall**
   - Removes .floppies
   - Optional: removes installed packages
   - Optional: restores dotfile backups

## 🖥️ Platform Support

### macOS
- ✅ Intel Macs
- ✅ Apple Silicon (M1/M2/M3)
- Uses Homebrew for package management

### Linux
- ✅ Ubuntu/Debian (apt)
- ✅ Fedora/RHEL/CentOS (dnf/yum)
- ✅ Arch/Manjaro (pacman)
- ✅ Other distributions (with manual adjustments)

### Windows
- ✅ WSL (Windows Subsystem for Linux)
- ✅ Git Bash
- ✅ PowerShell (with Chocolatey/Scoop)

## 📦 What Gets Installed

<details>
<summary>Core Packages (Click to expand)</summary>

- Git, Git LFS
- curl, wget
- OpenSSH, GnuPG
- Build tools (gcc, make, cmake)
- Compression tools (xz, zip, unzip)
- GNU utilities

</details>

<details>
<summary>Development Languages & Tools</summary>

- Node.js (via nvm) + npm, yarn, pnpm
- Python 3 (via pyenv) + pip, virtualenv, poetry
- Ruby (via rbenv) + bundler
- Go + workspace setup
- Rust (via rustup) + cargo
- Java OpenJDK
- TypeScript, ts-node
- ESLint, Prettier
- Testing frameworks

</details>

<details>
<summary>VSCode Extensions</summary>

- GitHub Copilot & Copilot Chat
- Remote Development (SSH, WSL, Containers)
- Python, C/C++, Go, Rust, Ruby, PHP support
- Docker & Kubernetes tools
- GitLens
- Prettier, ESLint
- Jupyter
- Terraform
- And more...

</details>

## ⚙️ Configuration

### Dotfiles
The installer creates/updates these configuration files:
- `.bashrc` / `.bash_profile`
- `.zshrc` (with Oh My Zsh)
- `.vimrc`
- `.tmux.conf`
- `.gitconfig`
- VSCode `settings.json`

### Backups
Before modifying any existing dotfiles, .floppies creates a backup at:
```
~/.dotfiles_backup_YYYYMMDD_HHMMSS/
```

### Shell Configuration
The installed shell configs include:
- Modern command aliases
- Git shortcuts
- PATH configuration for all installed tools
- Language version managers (nvm, pyenv, rbenv)
- Color support
- History configuration

## 🔧 Post-Installation

After installation:

1. **Restart your terminal** or run:
   ```bash
   source ~/.bashrc  # or ~/.zshrc
   ```

2. **Docker users**: Log out and back in for group changes to take effect

3. **Configure Git** (if not already configured):
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

4. **Install Vim plugins** (optional):
   ```bash
   vim +PlugInstall +qall
   ```

5. **Install tmux plugins** (optional):
   Press `Ctrl+a` then `I` in tmux

## 🐛 Troubleshooting

### Homebrew on Apple Silicon
If Homebrew commands aren't found after installation:
```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Permission issues
If you get permission errors, don't run the installer as root/sudo. It will prompt for sudo when needed.

### Missing packages
If a package fails to install, you can:
1. Run the installer again (it skips already installed packages)
2. Install manually using your package manager
3. Check the logs for specific errors

### VSCode extensions fail to install
If you're on WSL/remote systems, install VSCode on the host machine first.

## 🔄 Updating

To update .floppies and your installed tools:

```bash
cd .floppies
git pull
./install.sh
# Select option 4: Update Existing Installation
```

## 🗑️ Uninstalling

Run the installer and select option 5 (Uninstall), or:

```bash
./install.sh
# Select option 5: Uninstall
```

You'll be asked if you want to:
- Remove installed packages
- Remove dotfile configurations
- Restore from backup
- Remove .floppies directory

## 📚 Usage Examples

### Setting up a new development machine
```bash
git clone https://github.com/professoroakz/.floppies.git
cd .floppies
./install.sh
# Select option 1: Full Installation
# Wait for installation to complete
# Restart terminal
```

### Setting up a minimal server
```bash
./install.sh
# Select option 2: Core Essentials Only
```

### Adding specific tools to existing setup
```bash
./install.sh
# Select option 3: Custom Installation
# Select: 4 (Container Tools)
```

## 🤝 Contributing

Contributions are welcome! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

## 📚 Documentation

- **[README.md](README.md)** - Main documentation (you are here)
- **[FAQ](docs/FAQ.md)** - Frequently asked questions
- **[Platform Setup](docs/PLATFORM_SETUP.md)** - OS-specific guides
- **[Quick Reference](QUICKREF.md)** - Command cheatsheet
- **[CHANGELOG](CHANGELOG.md)** - Version history
- **[ROADMAP](ROADMAP.md)** - Future plans
- **[Wiki](wiki/)** - Detailed guides (import to GitHub Wiki)
- **[Categories](categories/)** - Installation profiles

## 🔒 Security

Security is important! See [SECURITY.md](SECURITY.md) for:
- Reporting vulnerabilities
- Security best practices
- Known security considerations

## 📝 License

MIT License - feel free to use and modify as needed. See [LICENSE](LICENSE) for details.

## 🎯 Philosophy

.floppies is designed to be:
- **Portable**: Works everywhere
- **Idempotent**: Safe to run multiple times
- **Modular**: Install only what you need
- **Safe**: Backs up existing configs
- **Modern**: Uses current best practices and tools

## 🔗 Related Projects

Based on analysis of these repositories:
- [dotfiles](https://github.com/professoroakz/dotfiles)
- [.baesreps](https://github.com/professoroakz/.baesreps)
- [.stripes](https://github.com/professoroakz/.stripes)

## 🔧 Maintenance & Updates

.floppies includes GitHub Actions to help keep everything fresh:

- **🔄 Weekly Dependency Checks** - Automated version checking
- **✅ CI/CD Testing** - Continuous integration on multiple platforms
- **🔒 Security Scanning** - Automated security audits
- **📝 Issue Templates** - Structured bug reports and feature requests

## 📊 Project Status

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/professoroakz/.floppies/test.yml)
![GitHub issues](https://img.shields.io/github/issues/professoroakz/.floppies)
![GitHub](https://img.shields.io/github/license/professoroakz/.floppies)

---

Made with ❤️ for developers who want to get up and running fast on any machine.
