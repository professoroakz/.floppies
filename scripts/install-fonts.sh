#!/usr/bin/env bash

#############################################
# Font Installation Module
# Installs popular programming fonts and powerline fonts
#############################################

install_fonts() {
    log_info "Installing fonts..."
    
    if [[ "$OS" == "macos" ]]; then
        install_fonts_macos
    elif [[ "$OS" == "linux" ]]; then
        install_fonts_linux
    else
        log_warn "Font installation not supported on $OS"
        return
    fi
    
    log_success "Fonts installed!"
}

install_fonts_macos() {
    log_info "Installing fonts on macOS..."
    
    # Install font management tools
    brew tap homebrew/cask-fonts
    
    # Install popular programming fonts
    local fonts=(
        "font-fira-code"              # Fira Code (ligatures)
        "font-jetbrains-mono"         # JetBrains Mono (ligatures)
        "font-cascadia-code"          # Cascadia Code (Microsoft)
        "font-hack"                   # Hack
        "font-source-code-pro"        # Source Code Pro (Adobe)
        "font-inconsolata"            # Inconsolata
        "font-meslo-lg-nerd-font"     # Meslo with Nerd Font patches
        "font-fira-code-nerd-font"    # Fira Code with Nerd Font patches
        "font-jetbrains-mono-nerd-font" # JetBrains Mono with Nerd Font
        "font-hack-nerd-font"         # Hack with Nerd Font patches
    )
    
    for font in "${fonts[@]}"; do
        if ! brew list --cask "$font" &>/dev/null; then
            log_info "Installing $font..."
            brew install --cask "$font" || log_warn "Failed to install $font"
        fi
    done
}

install_fonts_linux() {
    log_info "Installing fonts on Linux..."
    
    # Create fonts directory
    mkdir -p ~/.local/share/fonts
    
    # Install font management tools
    if command -v apt-get &>/dev/null; then
        sudo apt-get install -y fontconfig fonts-powerline
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y fontconfig powerline-fonts
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm ttf-hack ttf-fira-code ttf-jetbrains-mono powerline-fonts
        return # Arch has fonts in repos
    fi
    
    # Download and install Nerd Fonts
    local fonts_dir="$HOME/.local/share/fonts"
    local temp_dir="/tmp/nerd-fonts-install"
    mkdir -p "$temp_dir"
    
    # Download popular Nerd Fonts
    local nerd_fonts=(
        "FiraCode"
        "JetBrainsMono"
        "Hack"
        "Meslo"
        "CascadiaCode"
    )
    
    for font in "${nerd_fonts[@]}"; do
        log_info "Downloading $font Nerd Font..."
        local url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font}.zip"
        
        if curl -fsSL "$url" -o "$temp_dir/${font}.zip" 2>/dev/null; then
            unzip -q "$temp_dir/${font}.zip" -d "$fonts_dir/${font}" 2>/dev/null || true
            rm "$temp_dir/${font}.zip"
        else
            log_warn "Failed to download $font"
        fi
    done
    
    # Update font cache
    fc-cache -fv
    
    log_success "Fonts installed! You may need to restart applications."
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    source "$(dirname "$0")/../install.sh" --source-only
    install_fonts
fi
