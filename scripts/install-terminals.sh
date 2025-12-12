#!/usr/bin/env bash

#############################################
# Terminal Emulator Installation & Configuration
#############################################

install_terminal_emulators() {
    log_info "Installing terminal emulators..."
    
    case "$OS" in
        macos)
            install_macos_terminals
            ;;
        ubuntu|debian|fedora|rhel|centos|arch|manjaro)
            install_linux_terminals
            ;;
        windows)
            install_windows_terminals
            ;;
    esac
    
    log_success "Terminal emulators installed!"
}

install_macos_terminals() {
    log_info "Installing macOS terminal emulators..."
    
    # iTerm2 - Popular terminal for macOS
    if ! brew list --cask iterm2 &> /dev/null; then
        log_info "Installing iTerm2..."
        brew install --cask iterm2
    else
        log_info "iTerm2 already installed"
    fi
    
    # Warp - Modern terminal (Wave alternative)
    if ! brew list --cask warp &> /dev/null; then
        log_info "Installing Warp (modern terminal)..."
        brew install --cask warp || log_warning "Warp installation failed (may require Apple Silicon)"
    else
        log_info "Warp already installed"
    fi
    
    # Alacritty - GPU-accelerated terminal
    if ! brew list --cask alacritty &> /dev/null; then
        log_info "Installing Alacritty..."
        brew install --cask alacritty
    else
        log_info "Alacritty already installed"
    fi
    
    # Kitty - Fast, feature-rich terminal
    if ! brew list --cask kitty &> /dev/null; then
        log_info "Installing Kitty..."
        brew install --cask kitty
    else
        log_info "Kitty already installed"
    fi
    
    # Configure iTerm2 with dynamic color schemes
    configure_iterm2
}

install_linux_terminals() {
    log_info "Installing Linux terminal emulators..."
    
    case "$OS" in
        ubuntu|debian)
            # Tilix - Advanced GTK3 terminal
            sudo apt-get install -y tilix || true
            
            # Terminator - Multiple terminals in one window
            sudo apt-get install -y terminator || true
            
            # Alacritty
            sudo apt-get install -y alacritty || true
            
            # Kitty
            sudo apt-get install -y kitty || true
            ;;
        fedora|rhel|centos)
            if command -v dnf &> /dev/null; then
                sudo dnf install -y tilix alacritty kitty || true
            else
                sudo yum install -y tilix alacritty kitty || true
            fi
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm tilix alacritty kitty terminator || true
            ;;
    esac
}

install_windows_terminals() {
    log_info "Installing Windows terminal emulators..."
    
    if grep -qi microsoft /proc/version 2>/dev/null; then
        log_info "WSL detected. Install Windows Terminal from Microsoft Store."
        log_info "Or use: winget install Microsoft.WindowsTerminal"
    fi
    
    # Termius for cross-platform SSH
    log_info "For Termius, download from: https://termius.com/"
}

configure_iterm2() {
    log_info "Configuring iTerm2..."
    
    # Create iTerm2 dynamic profiles directory
    mkdir -p "$HOME/Library/Application Support/iTerm2/DynamicProfiles"
    
    # Create a dynamic color scheme profile
    cat > "$HOME/Library/Application Support/iTerm2/DynamicProfiles/ColorSchemes.json" << 'EOF'
{
  "Profiles": [
    {
      "Name": "Floppies Dynamic",
      "Guid": "floppies-dynamic-profile",
      "Dynamic Profile Parent Name": "Default",
      "Use Custom Command": "No",
      "Custom Command": "",
      "Initial Text": "",
      "Badge Text": "",
      "Working Directory": "~",
      "Custom Directory": "No"
    }
  ]
}
EOF
    
    log_success "iTerm2 configuration created"
}

install_color_schemes() {
    log_info "Installing terminal color schemes..."
    
    # Install base16-shell for dynamic color schemes
    if [ ! -d "$HOME/.config/base16-shell" ]; then
        log_info "Installing base16-shell (256+ color schemes)..."
        git clone https://github.com/chriskempson/base16-shell.git "$HOME/.config/base16-shell"
    else
        log_info "base16-shell already installed"
    fi
    
    # Install Gogh color schemes (for GNOME Terminal, Tilix, etc.)
    if [ ! -d "$HOME/.config/gogh" ]; then
        log_info "Installing Gogh color schemes..."
        mkdir -p "$HOME/.config/gogh"
        git clone https://github.com/Gogh-Co/Gogh.git "$HOME/.config/gogh"
    else
        log_info "Gogh color schemes already installed"
    fi
    
    log_success "Color schemes installed!"
}

configure_random_colors() {
    log_info "Setting up random color scheme on terminal start..."
    
    # Add to shell configuration
    local shell_config=""
    
    if [ -n "$BASH_VERSION" ]; then
        shell_config="$HOME/.bashrc"
    elif [ -n "$ZSH_VERSION" ]; then
        shell_config="$HOME/.zshrc"
    fi
    
    if [ -n "$shell_config" ]; then
        # Add base16-shell random color scheme
        cat >> "$shell_config" << 'EOF'

# Random color scheme on terminal start
if [ -d "$HOME/.config/base16-shell" ]; then
    BASE16_SHELL="$HOME/.config/base16-shell/"
    [ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && source "$BASE16_SHELL/profile_helper.sh"
    
    # Select a random color scheme
    if [ -z "$BASE16_THEME_LOADED" ]; then
        SCHEMES=("$BASE16_SHELL"/scripts/*.sh)
        RANDOM_SCHEME=${SCHEMES[$RANDOM % ${#SCHEMES[@]}]}
        source "$RANDOM_SCHEME"
    fi
fi
EOF
        log_success "Random color scheme configured in $shell_config"
    fi
}
