# .floppies Quick Reference

## Installation

```bash
# One-line install
curl -fsSL https://raw.githubusercontent.com/professoroakz/.floppies/main/quick-install.sh | bash

# Manual install
git clone https://github.com/professoroakz/.floppies.git
cd .floppies
./install.sh
```

## Menu Options

1. **Full Installation** - Everything (recommended for new machines)
2. **Core Essentials** - Just the basics
3. **Custom** - Pick components
4. **Update** - Update .floppies
5. **Uninstall** - Remove .floppies

## Post-Install

```bash
# Reload shell
source ~/.bashrc  # or ~/.zshrc

# Verify installation
./verify.sh

# Check what's installed
which node python3 docker kubectl code
```

## Version Managers

```bash
# Node.js (nvm)
nvm install --lts
nvm use --lts
nvm list

# Python (pyenv)
pyenv install 3.11.0
pyenv global 3.11.0
pyenv versions

# Ruby (rbenv)
rbenv install 3.2.0
rbenv global 3.2.0
rbenv versions

# Rust (rustup)
rustup update
rustup default stable
```

## Git Shortcuts (from .bashrc)

```bash
gs      # git status
ga      # git add
gc      # git commit
gp      # git push
gl      # git log --oneline --graph
```

## Docker Shortcuts

```bash
dps     # docker ps
dpsa    # docker ps -a
di      # docker images
dex     # docker exec -it
dlog    # docker logs -f
```

## Kubernetes Shortcuts

```bash
k       # kubectl
kgp     # kubectl get pods
kgs     # kubectl get services
kgd     # kubectl get deployments
```

## Modern CLI Tools

```bash
rg      # ripgrep (faster grep)
fd      # fd (faster find)
bat     # bat (better cat with syntax)
exa     # exa (modern ls)
fzf     # fuzzy finder
```

## Package Management

```bash
# macOS
brew update && brew upgrade

# Ubuntu/Debian
sudo apt update && sudo apt upgrade

# Fedora
sudo dnf upgrade

# Node.js
npm update -g

# Python
pip3 install --upgrade pip
pip3 list --outdated
```

## Updating .floppies

```bash
cd ~/.floppies  # or wherever you cloned it
git pull
./install.sh
# Select option 4
```

## Backup & Restore

```bash
# Backups are at:
~/.dotfiles_backup_*/

# To restore manually:
cp ~/.dotfiles_backup_*/.bashrc ~/
```

## Troubleshooting

```bash
# Command not found
source ~/.bashrc

# Docker permission denied (Linux)
sudo usermod -aG docker $USER
# Then logout and login

# Homebrew not found (Apple Silicon)
eval "$(/opt/homebrew/bin/brew shellenv)"
```

## Configuration Files

```
~/.bashrc           # Bash configuration
~/.zshrc            # Zsh configuration
~/.vimrc            # Vim configuration
~/.tmux.conf        # tmux configuration
~/.gitconfig        # Git configuration
~/.config/Code/     # VSCode settings (Linux)
~/Library/.../Code/ # VSCode settings (macOS)
```

## VSCode

```bash
# List extensions
code --list-extensions

# Install extension
code --install-extension <ext-name>

# Open from terminal
code .
```

## tmux Quick Keys

```
Ctrl+a          # Prefix key
Ctrl+a |        # Split vertically
Ctrl+a -        # Split horizontally
Ctrl+a c        # New window
Ctrl+a n/p      # Next/previous window
Ctrl+a d        # Detach
tmux attach     # Reattach
```

## Getting Help

```bash
# Check installation
./verify.sh

# Read docs
cat README.md
cat docs/FAQ.md
cat docs/PLATFORM_SETUP.md
```

## Uninstall

```bash
./install.sh
# Select option 5
# Follow prompts
```

---

For full documentation, see [README.md](README.md)
