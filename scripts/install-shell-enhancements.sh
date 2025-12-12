#!/usr/bin/env bash

#############################################
# Shell Enhancements Module
# Advanced shell configurations and tools
#############################################

install_shell_enhancements() {
    log_info "Installing shell enhancements..."
    
    # Install thefuck (command corrector)
    install_thefuck
    
    # Install autojump (smart directory navigation)
    install_autojump
    
    # Install z (frecent directory jumper)
    install_z
    
    # Install direnv (directory-specific environment variables)
    install_direnv
    
    # Install mosh (mobile shell, better than SSH for unstable connections)
    install_mosh
    
    # Install ncdu (NCurses Disk Usage)
    install_ncdu
    
    # Install tldr (simplified man pages)
    install_tldr
    
    log_success "Shell enhancements installed!"
}

install_thefuck() {
    if command -v thefuck &>/dev/null; then
        log_info "thefuck already installed"
        return
    fi
    
    log_info "Installing thefuck..."
    if [[ "$OS" == "macos" ]]; then
        brew install thefuck
    elif command -v apt-get &>/dev/null; then
        pip3 install --user thefuck
    elif command -v dnf &>/dev/null; then
        pip3 install --user thefuck
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm thefuck
    fi
}

install_autojump() {
    if command -v autojump &>/dev/null; then
        log_info "autojump already installed"
        return
    fi
    
    log_info "Installing autojump..."
    if [[ "$OS" == "macos" ]]; then
        brew install autojump
    elif command -v apt-get &>/dev/null; then
        sudo apt-get install -y autojump
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y autojump
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm autojump
    fi
}

install_z() {
    if [ -f ~/.z.sh ]; then
        log_info "z already installed"
        return
    fi
    
    log_info "Installing z..."
    local temp_file="/tmp/z.sh.$$"
    
    if curl -fsSL https://raw.githubusercontent.com/rupa/z/master/z.sh -o "$temp_file"; then
        # Basic validation - check if file is not empty and contains expected content
        if [ -s "$temp_file" ] && grep -q "# z.sh" "$temp_file" 2>/dev/null; then
            mv "$temp_file" ~/.z.sh
            log_success "z installed successfully"
        else
            log_error "Downloaded z.sh appears invalid"
            rm -f "$temp_file"
            return 1
        fi
    else
        log_error "Failed to download z.sh"
        rm -f "$temp_file"
        return 1
    fi
}

install_direnv() {
    if command -v direnv &>/dev/null; then
        log_info "direnv already installed"
        return
    fi
    
    log_info "Installing direnv..."
    if [[ "$OS" == "macos" ]]; then
        brew install direnv
    elif command -v apt-get &>/dev/null; then
        sudo apt-get install -y direnv
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y direnv
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm direnv
    fi
}

install_mosh() {
    if command -v mosh &>/dev/null; then
        log_info "mosh already installed"
        return
    fi
    
    log_info "Installing mosh..."
    if [[ "$OS" == "macos" ]]; then
        brew install mosh
    elif command -v apt-get &>/dev/null; then
        sudo apt-get install -y mosh
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y mosh
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm mosh
    fi
}

install_ncdu() {
    if command -v ncdu &>/dev/null; then
        log_info "ncdu already installed"
        return
    fi
    
    log_info "Installing ncdu..."
    if [[ "$OS" == "macos" ]]; then
        brew install ncdu
    elif command -v apt-get &>/dev/null; then
        sudo apt-get install -y ncdu
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y ncdu
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm ncdu
    fi
}

install_tldr() {
    if command -v tldr &>/dev/null; then
        log_info "tldr already installed"
        return
    fi
    
    log_info "Installing tldr..."
    if [[ "$OS" == "macos" ]]; then
        brew install tldr
    elif command -v npm &>/dev/null; then
        npm install -g tldr
    else
        pip3 install --user tldr
    fi
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # Define logging functions if not already defined
    if ! command -v log_info &>/dev/null; then
        RED='\033[0;31m'
        GREEN='\033[0;32m'
        YELLOW='\033[1;33m'
        BLUE='\033[0;34m'
        NC='\033[0m'
        
        log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
        log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
        log_warn() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
        log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
    fi
    
    # Detect OS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    else
        OS="linux"
    fi
    
    install_shell_enhancements
fi
