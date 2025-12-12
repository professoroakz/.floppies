#!/usr/bin/env bash

#############################################
# macOS-specific installation functions
#############################################

install_core_macos() {
    log_info "Installing core essentials for macOS..."
    
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Apple Silicon
        if [[ $(uname -m) == 'arm64' ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
        log_info "Homebrew already installed. Updating..."
        brew update
    fi
    
    # Install essential packages
    log_info "Installing essential packages..."
    
    # Core utilities
    brew install coreutils findutils gnu-sed gnu-tar gawk grep
    
    # Modern shell
    brew install bash zsh
    
    # Version control
    brew install git git-lfs
    
    # Essential tools
    brew install curl wget
    brew install openssh
    brew install gnupg
    
    # Compression tools
    brew install xz
    
    log_success "Core essentials for macOS installed!"
}

install_homebrew_packages() {
    local packages=("$@")
    
    for package in "${packages[@]}"; do
        if brew list "$package" &> /dev/null; then
            log_info "$package is already installed"
        else
            log_info "Installing $package..."
            brew install "$package"
        fi
    done
}

install_homebrew_cask() {
    local cask=("$@")
    
    for app in "${cask[@]}"; do
        if brew list --cask "$app" &> /dev/null; then
            log_info "$app is already installed"
        else
            log_info "Installing $app..."
            brew install --cask "$app"
        fi
    done
}
