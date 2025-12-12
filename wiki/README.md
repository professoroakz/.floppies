# .floppies Wiki

Welcome to the .floppies wiki! This directory contains detailed guides and documentation.

## Wiki Structure

To use this content on GitHub Wiki:

1. Go to your repository's Wiki tab
2. Import these markdown files
3. Organize them as pages

## Pages

### Getting Started
- [Home](Home.md) - Wiki homepage
- [Quick Start](Quick-Start.md) - Get up and running fast
- [Installation Guide](Installation-Guide.md) - Detailed installation
- [First Time Setup](First-Time-Setup.md) - After installation

### Platform Guides
- [macOS Guide](macOS-Guide.md) - macOS specific instructions
- [Ubuntu Guide](Ubuntu-Guide.md) - Ubuntu/Debian instructions
- [Windows WSL Guide](Windows-WSL-Guide.md) - Windows Subsystem for Linux
- [Arch Linux Guide](Arch-Linux-Guide.md) - Arch/Manjaro instructions

### Tool Guides
- [Node.js Setup](Nodejs-Setup.md) - Node.js and npm
- [Python Setup](Python-Setup.md) - Python and pip
- [Docker Setup](Docker-Setup.md) - Docker and containers
- [VSCode Setup](VSCode-Setup.md) - Visual Studio Code
- [Git Configuration](Git-Configuration.md) - Git setup and tips

### Advanced Topics
- [Custom Profiles](Custom-Profiles.md) - Creating custom install profiles
- [Dotfiles Management](Dotfiles-Management.md) - Managing configurations
- [Troubleshooting](Troubleshooting.md) - Common issues and solutions
- [Performance Tuning](Performance-Tuning.md) - Optimization tips
- [Security Hardening](Security-Hardening.md) - Security best practices

### Reference
- [Tool List](Tool-List.md) - Complete list of available tools
- [Command Reference](Command-Reference.md) - Common commands
- [Environment Variables](Environment-Variables.md) - PATH and env vars
- [Keyboard Shortcuts](Keyboard-Shortcuts.md) - Useful shortcuts

### Development
- [Contributing](Contributing.md) - How to contribute
- [Architecture](Architecture.md) - System design
- [Testing](Testing.md) - How to test changes
- [Release Process](Release-Process.md) - How releases are made

## Creating Wiki Content

To add new wiki pages:

1. Create markdown file in this directory
2. Add to the list above
3. Link from relevant pages
4. Update navigation in sidebar

## Importing to GitHub Wiki

```bash
# Clone the wiki repo
git clone https://github.com/professoroakz/.floppies.wiki.git

# Copy markdown files
cp wiki/*.md .floppies.wiki/

# Commit and push
cd .floppies.wiki
git add .
git commit -m "Update wiki content"
git push
```

## Maintenance

- Keep pages up to date with main README
- Add screenshots and examples
- Link between related pages
- Test code examples
- Update for new features

---

**Note**: This wiki structure is provided as a starting point. Customize as needed for your documentation needs.
