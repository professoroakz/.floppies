# .floppies Categories System

This directory contains categorized package lists that can be used for modular installations.

## Directory Structure

```
categories/
├── web-dev.list          # Web development tools
├── data-science.list     # Data science and ML tools
├── devops.list           # DevOps and infrastructure tools
├── mobile-dev.list       # Mobile development tools
├── gamedev.list          # Game development tools
├── security.list         # Security and pentesting tools
├── blockchain.list       # Blockchain and crypto tools
├── minimal.list          # Minimal essentials
└── full.list            # Everything
```

## Usage

These category files can be used to create customized installation profiles:

```bash
# Install web development profile
./install.sh --profile web-dev

# Install multiple profiles
./install.sh --profile web-dev,devops,security

# Create custom profile
cat categories/web-dev.list categories/devops.list > my-profile.list
```

## Category Format

Each `.list` file contains:

```
# Category: Web Development
# Description: Tools for web development

# Languages & Runtimes
node:18       # Node.js LTS
python:3.12   # Python
ruby:3.2      # Ruby

# Frameworks (npm packages)
npm:@vue/cli
npm:create-react-app
npm:@angular/cli

# Tools
vscode-extension:esbenp.prettier-vscode
vscode-extension:dbaeumer.vscode-eslint
```

## Creating New Categories

1. Create a new `.list` file in this directory
2. Follow the format above
3. Add description at the top
4. List tools with their categories
5. Test the installation
6. Update this README

## Reusability

These categories can be:

- Used in .floppies installation
- Exported for other projects
- Shared as gists
- Imported from remote URLs
- Version controlled separately

## Contributing

To add a new category:

1. Create `categories/your-category.list`
2. Follow existing format
3. Test on multiple platforms
4. Submit PR with description

---

**Note**: This feature is in development. Check main README for current implementation status.
