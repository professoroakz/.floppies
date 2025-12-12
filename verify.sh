#!/usr/bin/env bash

#############################################
# .floppies Installation Verification
#############################################
# Tests that installations were successful

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

PASS_COUNT=0
FAIL_COUNT=0

echo ""
echo "╔═══════════════════════════════════════╗"
echo "║   .floppies Verification Test         ║"
echo "╚═══════════════════════════════════════╝"
echo ""

# Test helper function
test_command() {
    local cmd=$1
    local name=${2:-$1}
    
    if command -v "$cmd" &> /dev/null; then
        echo -e "${GREEN}✓${NC} $name"
        ((PASS_COUNT++))
        return 0
    else
        echo -e "${RED}✗${NC} $name"
        ((FAIL_COUNT++))
        return 1
    fi
}

# Test file exists
test_file() {
    local file=$1
    local name=${2:-$1}
    
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓${NC} $name"
        ((PASS_COUNT++))
        return 0
    else
        echo -e "${RED}✗${NC} $name"
        ((FAIL_COUNT++))
        return 1
    fi
}

# Test directory exists
test_dir() {
    local dir=$1
    local name=${2:-$1}
    
    if [ -d "$dir" ]; then
        echo -e "${GREEN}✓${NC} $name"
        ((PASS_COUNT++))
        return 0
    else
        echo -e "${RED}✗${NC} $name"
        ((FAIL_COUNT++))
        return 1
    fi
}

echo "Testing Core Tools..."
echo "-----------------------------------"
test_command git "Git"
test_command curl "cURL"
test_command wget "wget"
test_command ssh "SSH"
if ! test_command gpg "GnuPG"; then
    if test_command gpg2 "GnuPG2"; then
        ((PASS_COUNT++))
        ((FAIL_COUNT--))
    fi
fi
echo ""

echo "Testing Development Languages..."
echo "-----------------------------------"
test_command node "Node.js"
test_command npm "npm"
test_command python3 "Python 3"
test_command pip3 "pip3"
test_command ruby "Ruby"
test_command gem "gem"
test_command go "Go" || echo -e "${YELLOW}⊘${NC} Go (optional)"
test_command rustc "Rust" || echo -e "${YELLOW}⊘${NC} Rust (optional)"
echo ""

echo "Testing Version Managers..."
echo "-----------------------------------"
test_dir "$HOME/.nvm" "nvm"
test_dir "$HOME/.pyenv" "pyenv" || echo -e "${YELLOW}⊘${NC} pyenv (optional)"
test_dir "$HOME/.rbenv" "rbenv" || echo -e "${YELLOW}⊘${NC} rbenv (optional)"
test_dir "$HOME/.cargo" "cargo/rustup" || echo -e "${YELLOW}⊘${NC} rustup (optional)"
echo ""

echo "Testing Shells..."
echo "-----------------------------------"
test_command bash "Bash"
test_command zsh "Zsh"
test_dir "$HOME/.oh-my-zsh" "Oh My Zsh" || echo -e "${YELLOW}⊘${NC} Oh My Zsh (optional)"
test_command starship "Starship" || echo -e "${YELLOW}⊘${NC} Starship (optional)"
echo ""

echo "Testing Editors..."
echo "-----------------------------------"
test_command vim "Vim"
test_command nvim "Neovim" || echo -e "${YELLOW}⊘${NC} Neovim (optional)"
test_command code "VSCode" || echo -e "${YELLOW}⊘${NC} VSCode (may be in GUI)"
echo ""

echo "Testing Terminal Tools..."
echo "-----------------------------------"
test_command tmux "tmux"
test_command screen "screen"
test_command rg "ripgrep" || echo -e "${YELLOW}⊘${NC} ripgrep (optional)"
test_command fd "fd" || echo -e "${YELLOW}⊘${NC} fd (optional)"
test_command bat "bat" || echo -e "${YELLOW}⊘${NC} bat (optional)"
test_command fzf "fzf" || echo -e "${YELLOW}⊘${NC} fzf (optional)"
test_command htop "htop" || echo -e "${YELLOW}⊘${NC} htop (optional)"
echo ""

echo "Testing Container Tools..."
echo "-----------------------------------"
test_command docker "Docker" || echo -e "${YELLOW}⊘${NC} Docker (optional)"
test_command docker-compose "Docker Compose" || echo -e "${YELLOW}⊘${NC} Docker Compose (optional)"
test_command kubectl "kubectl" || echo -e "${YELLOW}⊘${NC} kubectl (optional)"
test_command helm "Helm" || echo -e "${YELLOW}⊘${NC} Helm (optional)"
echo ""

echo "Testing Cloud Tools..."
echo "-----------------------------------"
test_command aws "AWS CLI" || echo -e "${YELLOW}⊘${NC} AWS CLI (optional)"
test_command az "Azure CLI" || echo -e "${YELLOW}⊘${NC} Azure CLI (optional)"
test_command gcloud "Google Cloud SDK" || echo -e "${YELLOW}⊘${NC} gcloud (optional)"
test_command terraform "Terraform" || echo -e "${YELLOW}⊘${NC} Terraform (optional)"
echo ""

echo "Testing Dotfiles..."
echo "-----------------------------------"
test_file "$HOME/.bashrc" ".bashrc"
test_file "$HOME/.bash_profile" ".bash_profile"
test_file "$HOME/.gitconfig" ".gitconfig"
test_file "$HOME/.vimrc" ".vimrc" || echo -e "${YELLOW}⊘${NC} .vimrc (optional)"
test_file "$HOME/.tmux.conf" ".tmux.conf" || echo -e "${YELLOW}⊘${NC} .tmux.conf (optional)"
echo ""

# Summary
echo "═══════════════════════════════════════"
echo "Summary:"
echo -e "${GREEN}Passed: $PASS_COUNT${NC}"
echo -e "${RED}Failed: $FAIL_COUNT${NC}"
echo ""

if [ $FAIL_COUNT -eq 0 ]; then
    echo -e "${GREEN}All critical tests passed!${NC}"
    echo ""
    echo "Your development environment is ready! 🎉"
    exit 0
else
    echo -e "${YELLOW}Some tests failed, but that might be okay.${NC}"
    echo "Failed items might be optional components you didn't install."
    echo ""
    echo "To install missing components:"
    echo "  ./install.sh"
    echo "  Select option 3: Custom Installation"
    exit 1
fi
