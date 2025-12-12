#!/usr/bin/env bash

###############################################################################
# .floppies Quick Install
###############################################################################
# One-liner installation script
# Usage: curl -fsSL https://raw.githubusercontent.com/professoroakz/.floppies/main/quick-install.sh | bash
###############################################################################

set -e

REPO_URL="https://github.com/professoroakz/.floppies.git"
INSTALL_DIR="$HOME/.floppies"

echo ""
echo "╔═══════════════════════════════════════╗"
echo "║     .floppies - Quick Install         ║"
echo "╚═══════════════════════════════════════╝"
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Error: git is not installed. Please install git first."
    exit 1
fi

# Clone or update repository
if [ -d "$INSTALL_DIR" ]; then
    echo "Updating existing .floppies installation..."
    cd "$INSTALL_DIR"
    git pull origin main
else
    echo "Cloning .floppies repository..."
    git clone "$REPO_URL" "$INSTALL_DIR"
    cd "$INSTALL_DIR"
fi

# Make installer executable
chmod +x install.sh

# Run installer
echo ""
echo "Starting .floppies installer..."
echo ""
./install.sh

echo ""
echo "Quick install complete!"
echo ""
