# Frequently Asked Questions (FAQ)

## General Questions

### Q: What is .floppies?
A: .floppies is a universal development environment setup tool that installs and configures everything you need for software development on macOS, Linux, Windows, and Unix systems.

### Q: Why "floppies"?
A: Because like the old floppy disks, this is your portable development environment that you can take anywhere and set up on any machine!

### Q: Is it safe to run?
A: Yes! The installer:
- Backs up existing configurations before making changes
- Only asks for sudo/admin when needed
- Can be run multiple times safely (idempotent)
- Provides an uninstall option

### Q: How long does installation take?
A: Depends on your selection:
- Core essentials: ~5 minutes
- Full installation: ~15-30 minutes
- Custom installation: varies

### Q: Will it break my existing setup?
A: No. The installer:
- Creates backups of existing dotfiles
- Skips packages that are already installed
- Uses standard package managers
- Can be safely uninstalled

---

## Installation Questions

### Q: Do I need to run as root/sudo?
A: No! Run as your regular user. The installer will prompt for sudo when needed.

### Q: Can I install only specific components?
A: Yes! Choose option 3 (Custom Installation) from the menu and select what you want.

### Q: Can I run it multiple times?
A: Yes! It's safe to re-run and will skip already installed packages.

### Q: What if the installation fails?
A: The installer continues even if individual packages fail. You can:
1. Re-run the installer
2. Check the error messages
3. Install failed packages manually

---

## Platform Questions

### Q: Which operating systems are supported?
A: 
- ✅ macOS (Intel and Apple Silicon)
- ✅ Ubuntu/Debian
- ✅ Fedora/RHEL/CentOS
- ✅ Arch/Manjaro
- ✅ Windows (WSL, Git Bash, PowerShell)

### Q: Does it work on Apple Silicon Macs?
A: Yes! Fully supports M1/M2/M3 Macs with automatic path configuration.

### Q: Does it work in WSL?
A: Yes! WSL is fully supported and recommended for Windows users.

### Q: Can I use it on a server?
A: Yes! Use option 2 (Core Essentials Only) for minimal server setups.

---

## Configuration Questions

### Q: Where are my dotfiles?
A: In your home directory:
- `~/.bashrc`
- `~/.bash_profile`
- `~/.zshrc`
- `~/.vimrc`
- `~/.tmux.conf`
- `~/.gitconfig`

### Q: Where are backups stored?
A: `~/.dotfiles_backup_YYYYMMDD_HHMMSS/`

### Q: Can I customize the configurations?
A: Yes! Edit the files in your home directory after installation.

### Q: How do I revert changes?
A: Run the uninstaller (option 5) and choose to restore from backup.

---

## Tools & Packages Questions

### Q: What gets installed in a full installation?
A: See the README for complete list, but includes:
- Development languages (Node.js, Python, Ruby, Go, Rust)
- Editors (VSCode, Vim)
- Terminal tools (tmux, modern CLI tools)
- Container tools (Docker, Kubernetes)
- Cloud CLIs (AWS, Azure, GCP)
- And much more

### Q: Can I skip VSCode installation?
A: Yes! Use custom installation and don't select editors.

### Q: Why so many VSCode extensions?
A: They cover common development needs. Unused extensions can be disabled in VSCode.

### Q: Do I need all the security tools?
A: No. Use custom installation if you don't need security tools.

---

## Version Management Questions

### Q: How do I manage Node.js versions?
A: Use nvm (installed automatically):
```bash
nvm install 18
nvm use 18
nvm alias default 18
```

### Q: How do I manage Python versions?
A: Use pyenv (installed automatically):
```bash
pyenv install 3.11.0
pyenv global 3.11.0
```

### Q: How do I manage Ruby versions?
A: Use rbenv (installed automatically):
```bash
rbenv install 3.2.0
rbenv global 3.2.0
```

---

## Updating Questions

### Q: How do I update .floppies?
A: Run `./install.sh` and select option 4 (Update).

### Q: How do I update installed packages?
A:
- **macOS**: `brew update && brew upgrade`
- **Ubuntu/Debian**: `sudo apt-get update && sudo apt-get upgrade`
- **Fedora**: `sudo dnf upgrade`

### Q: Will updating break things?
A: Updates via option 4 re-run the installer safely.

---

## Troubleshooting Questions

### Q: Command not found after installation?
A: Restart your terminal or run:
```bash
source ~/.bashrc  # or ~/.zshrc
```

### Q: Docker permission denied?
A: Log out and back in (needed for group changes):
```bash
sudo usermod -aG docker $USER
```

### Q: Homebrew command not found (Apple Silicon)?
A:
```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Q: Package installation failed?
A: Check your internet connection and try again. You can also install packages manually using your package manager.

---

## Uninstallation Questions

### Q: How do I uninstall?
A: Run `./install.sh` and select option 5 (Uninstall).

### Q: Will uninstall remove all packages?
A: You'll be asked if you want to remove packages. Choose based on your needs.

### Q: Can I restore my old configurations?
A: Yes! The uninstaller can restore from the backup it created.

---

## Advanced Questions

### Q: Can I modify the installation scripts?
A: Yes! Fork the repo and customize as needed. It's MIT licensed.

### Q: Can I add my own dotfiles?
A: Yes! Add them to the `dotfiles/` directory and modify `configure-dotfiles.sh`.

### Q: Can I use this in CI/CD?
A: Yes! Use option 2 (Core) or 3 (Custom) for automated setups:
```bash
./install.sh <<< "2"
```

### Q: Can I create a custom installation profile?
A: Yes! Modify the install scripts or create your own in the scripts directory.

---

## Performance Questions

### Q: How much disk space is needed?
A:
- Core essentials: ~500MB
- Full installation: ~5-10GB (varies by platform)

### Q: Does it slow down my computer?
A: No. Tools only run when you use them.

### Q: Can I install on a slow connection?
A: Yes, but it may take longer. Consider Core Essentials Only option.

---

## Support Questions

### Q: Where can I get help?
A: 
- Check the [README](../README.md)
- Review [Platform Setup](PLATFORM_SETUP.md)
- Check GitHub Issues

### Q: How do I report a bug?
A: Create an issue on GitHub with:
- Your OS and version
- Error messages
- Steps to reproduce

### Q: Can I contribute?
A: Yes! Fork the repo and submit pull requests.

---

## Mobile/Tablet Questions

### Q: Does it work on iOS/iPadOS?
A: Not directly, but you can use it on:
- Remote servers accessed via iOS
- Cloud development environments
- Linux containers on iPad

### Q: Does it work on Android?
A: Yes, in Termux or similar Linux environments.

---

## More Questions?

If your question isn't answered here:
1. Check the [README](../README.md)
2. Review the [Platform Setup Guide](PLATFORM_SETUP.md)
3. Search GitHub Issues
4. Create a new issue

---

Last updated: 2024
