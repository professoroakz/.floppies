# Platform-Specific Setup Guides

This document provides detailed setup instructions for different operating systems.

## macOS Setup

### Prerequisites
- macOS 10.15 (Catalina) or later
- Command Line Tools for Xcode (installer will prompt)
- Administrator access

### Installation
```bash
git clone https://github.com/professoroakz/.floppies.git
cd .floppies
./install.sh
```

### Apple Silicon (M1/M2/M3) Notes
- Homebrew installs to `/opt/homebrew` instead of `/usr/local`
- Some x86 packages may require Rosetta 2
- The installer automatically configures paths for Apple Silicon

### Post-Installation
```bash
# Restart terminal or reload profile
source ~/.bash_profile  # or ~/.zshrc

# Verify Homebrew
brew doctor

# Install Xcode Command Line Tools if prompted
xcode-select --install
```

---

## Ubuntu/Debian Setup

### Prerequisites
- Ubuntu 20.04+ or Debian 10+
- sudo access
- Internet connection

### Installation
```bash
# Update package lists
sudo apt-get update

# Install git if not present
sudo apt-get install -y git

# Clone and run
git clone https://github.com/professoroakz/.floppies.git
cd .floppies
./install.sh
```

### WSL (Windows Subsystem for Linux)
If you're running Ubuntu on WSL:
```bash
# Install WSL utilities
sudo apt-get install -y ubuntu-wsl

# Run .floppies
./install.sh

# VSCode integration
code .
```

---

## Windows Setup

### Option 1: WSL (Recommended)

#### Install WSL
```powershell
# Run in PowerShell as Administrator
wsl --install
```

#### Install .floppies in WSL
```bash
# In WSL terminal
git clone https://github.com/professoroakz/.floppies.git
cd .floppies
./install.sh
```

### Option 2: Git Bash

#### Prerequisites
- [Git for Windows](https://git-scm.com/download/win)
- [Chocolatey](https://chocolatey.org/install) or [Scoop](https://scoop.sh/)

#### Installation
```bash
# In Git Bash
git clone https://github.com/professoroakz/.floppies.git
cd .floppies
./install.sh
```

---

For complete platform guides, see [README.md](../README.md).
