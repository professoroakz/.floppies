#!/usr/bin/env bash

#############################################
# Unit Tests for Installation Scripts
#############################################

set -e

# Load test framework
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test-framework.sh"

cd "$SCRIPT_DIR/.."

echo ""
echo "╔═══════════════════════════════════════╗"
echo "║   Testing Installation Modules        ║"
echo "╚═══════════════════════════════════════╝"
echo ""

# Test that all expected scripts exist
echo "Testing Script Files:"

test_start "install-macos.sh exists"
if assert_file_exists "scripts/install-macos.sh"; then
    test_pass
fi

test_start "install-linux.sh exists"
if assert_file_exists "scripts/install-linux.sh"; then
    test_pass
fi

test_start "install-windows.sh exists"
if assert_file_exists "scripts/install-windows.sh"; then
    test_pass
fi

test_start "install-dev-tools.sh exists"
if assert_file_exists "scripts/install-dev-tools.sh"; then
    test_pass
fi

test_start "install-editors.sh exists"
if assert_file_exists "scripts/install-editors.sh"; then
    test_pass
fi

test_start "install-terminal.sh exists"
if assert_file_exists "scripts/install-terminal.sh"; then
    test_pass
fi

test_start "install-containers.sh exists"
if assert_file_exists "scripts/install-containers.sh"; then
    test_pass
fi

test_start "install-cloud.sh exists"
if assert_file_exists "scripts/install-cloud.sh"; then
    test_pass
fi

test_start "install-security.sh exists"
if assert_file_exists "scripts/install-security.sh"; then
    test_pass
fi

test_start "install-datascience.sh exists"
if assert_file_exists "scripts/install-datascience.sh"; then
    test_pass
fi

test_start "configure-dotfiles.sh exists"
if assert_file_exists "scripts/configure-dotfiles.sh"; then
    test_pass
fi

test_start "uninstall.sh exists"
if assert_file_exists "scripts/uninstall.sh"; then
    test_pass
fi

# Test script syntax
echo ""
echo "Testing Script Syntax:"

for script in scripts/*.sh; do
    test_start "$(basename "$script") has valid syntax"
    if bash -n "$script" 2>&1; then
        test_pass
    else
        test_fail "Syntax error in $script"
    fi
done

# Test macOS module
echo ""
echo "Testing macOS Module Functions:"

test_start "install-macos.sh has install_core_macos function"
if grep -q "install_core_macos()" scripts/install-macos.sh; then
    test_pass
else
    test_fail "install_core_macos function not found"
fi

test_start "install-macos.sh checks for Homebrew"
if grep -q "brew" scripts/install-macos.sh; then
    test_pass
else
    test_fail "Script should reference Homebrew"
fi

# Test Linux module
echo ""
echo "Testing Linux Module Functions:"

test_start "install-linux.sh has install_core_linux function"
if grep -q "install_core_linux()" scripts/install-linux.sh; then
    test_pass
else
    test_fail "install_core_linux function not found"
fi

test_start "install-linux.sh has Debian support"
if grep -q "install_core_debian()" scripts/install-linux.sh; then
    test_pass
else
    test_fail "Debian support function not found"
fi

test_start "install-linux.sh has RedHat support"
if grep -q "install_core_redhat()" scripts/install-linux.sh; then
    test_pass
else
    test_fail "RedHat support function not found"
fi

test_start "install-linux.sh has Arch support"
if grep -q "install_core_arch()" scripts/install-linux.sh; then
    test_pass
else
    test_fail "Arch support function not found"
fi

# Test Windows module
echo ""
echo "Testing Windows Module Functions:"

test_start "install-windows.sh has install_core_windows function"
if grep -q "install_core_windows()" scripts/install-windows.sh; then
    test_pass
else
    test_fail "install_core_windows function not found"
fi

test_start "install-windows.sh checks for WSL"
if grep -q "WSL\|wsl\|microsoft" scripts/install-windows.sh; then
    test_pass
else
    test_fail "Script should check for WSL"
fi

# Test dev-tools module
echo ""
echo "Testing Development Tools Module:"

test_start "install-dev-tools.sh has install_dev_tools function"
if grep -q "install_dev_tools()" scripts/install-dev-tools.sh; then
    test_pass
else
    test_fail "install_dev_tools function not found"
fi

test_start "install-dev-tools.sh installs Node.js"
if grep -q "node\|nvm" scripts/install-dev-tools.sh; then
    test_pass
else
    test_fail "Should install Node.js"
fi

test_start "install-dev-tools.sh installs Python"
if grep -q "python\|pyenv" scripts/install-dev-tools.sh; then
    test_pass
else
    test_fail "Should install Python"
fi

test_start "install-dev-tools.sh installs Ruby"
if grep -q "ruby\|rbenv" scripts/install-dev-tools.sh; then
    test_pass
else
    test_fail "Should install Ruby"
fi

# Test editors module
echo ""
echo "Testing Editors Module:"

test_start "install-editors.sh has install_editors function"
if grep -q "install_editors()" scripts/install-editors.sh; then
    test_pass
else
    test_fail "install_editors function not found"
fi

test_start "install-editors.sh installs VSCode"
if grep -q "vscode\|visual-studio-code\|code" scripts/install-editors.sh; then
    test_pass
else
    test_fail "Should install VSCode"
fi

test_start "install-editors.sh installs Vim"
if grep -q "vim\|neovim" scripts/install-editors.sh; then
    test_pass
else
    test_fail "Should install Vim/Neovim"
fi

# Test containers module
echo ""
echo "Testing Containers Module:"

test_start "install-containers.sh has install_containers function"
if grep -q "install_containers()" scripts/install-containers.sh; then
    test_pass
else
    test_fail "install_containers function not found"
fi

test_start "install-containers.sh installs Docker"
if grep -q "docker" scripts/install-containers.sh; then
    test_pass
else
    test_fail "Should install Docker"
fi

test_start "install-containers.sh installs kubectl"
if grep -q "kubectl" scripts/install-containers.sh; then
    test_pass
else
    test_fail "Should install kubectl"
fi

# Test dotfiles configuration
echo ""
echo "Testing Dotfiles Configuration:"

test_start "configure-dotfiles.sh has configure_dotfiles function"
if grep -q "configure_dotfiles()" scripts/configure-dotfiles.sh; then
    test_pass
else
    test_fail "configure_dotfiles function not found"
fi

test_start "configure-dotfiles.sh backs up existing files"
if grep -q "backup" scripts/configure-dotfiles.sh; then
    test_pass
else
    test_fail "Should backup existing dotfiles"
fi

test_start "configure-dotfiles.sh configures bashrc"
if grep -q "bashrc\|.bashrc" scripts/configure-dotfiles.sh; then
    test_pass
else
    test_fail "Should configure .bashrc"
fi

test_start "configure-dotfiles.sh configures Git"
if grep -q "gitconfig\|.gitconfig" scripts/configure-dotfiles.sh; then
    test_pass
else
    test_fail "Should configure Git"
fi

# Print summary
test_summary
