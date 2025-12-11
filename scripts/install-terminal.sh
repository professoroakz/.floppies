#!/usr/bin/env bash

#############################################
# Terminal Tools Installation
#############################################

install_terminal_tools() {
    log_info "Installing terminal tools..."
    
    install_shell_tools
    install_modern_cli_tools
    install_multiplexers
    
    log_success "Terminal tools installed!"
}

install_shell_tools() {
    log_info "Installing shell and shell tools..."
    
    case "$OS" in
        macos)
            brew install bash zsh fish
            brew install bash-completion zsh-completions
            ;;
        ubuntu|debian)
            sudo apt-get install -y bash zsh fish
            sudo apt-get install -y bash-completion
            ;;
        fedora|rhel|centos)
            if command -v dnf &> /dev/null; then
                sudo dnf install -y bash zsh fish
                sudo dnf install -y bash-completion
            else
                sudo yum install -y bash zsh fish
                sudo yum install -y bash-completion
            fi
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm bash zsh fish
            sudo pacman -S --noconfirm bash-completion
            ;;
    esac
    
    # Install Oh My Zsh
    install_oh_my_zsh
    
    # Install Starship prompt
    install_starship
}

install_oh_my_zsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        log_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        
        # Install popular plugins
        git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" 2>/dev/null || true
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" 2>/dev/null || true
        git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions" 2>/dev/null || true
    else
        log_info "Oh My Zsh already installed"
    fi
}

install_starship() {
    if ! command -v starship &> /dev/null; then
        log_info "Installing Starship prompt..."
        curl -sS https://starship.rs/install.sh | sh -s -- -y
    else
        log_info "Starship already installed"
    fi
}

install_modern_cli_tools() {
    log_info "Installing modern CLI tools..."
    
    case "$OS" in
        macos)
            brew install ripgrep fd bat exa fzf htop ncdu tldr
            brew install jq yq
            brew install tree
            brew install httpie
            brew install the_silver_searcher
            ;;
        ubuntu|debian)
            sudo apt-get install -y ripgrep fd-find bat fzf htop ncdu tldr
            sudo apt-get install -y jq tree httpie silversearcher-ag
            
            # bat and fd have different names on Debian/Ubuntu
            mkdir -p ~/.local/bin
            ln -sf $(which batcat) ~/.local/bin/bat 2>/dev/null || true
            ln -sf $(which fdfind) ~/.local/bin/fd 2>/dev/null || true
            
            # Install exa from cargo if available
            if command -v cargo &> /dev/null; then
                cargo install exa
            fi
            ;;
        fedora|rhel|centos)
            if command -v dnf &> /dev/null; then
                sudo dnf install -y ripgrep fd-find bat fzf htop ncdu
                sudo dnf install -y jq tree httpie the_silver_searcher
            else
                sudo yum install -y ripgrep fd-find bat fzf htop ncdu
                sudo yum install -y jq tree httpie the_silver_searcher
            fi
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm ripgrep fd bat exa fzf htop ncdu tldr
            sudo pacman -S --noconfirm jq tree httpie the_silver_searcher
            ;;
        windows)
            if grep -qi microsoft /proc/version 2>/dev/null; then
                # WSL
                sudo apt-get install -y ripgrep fd-find bat fzf htop
                mkdir -p ~/.local/bin
                ln -sf $(which batcat) ~/.local/bin/bat 2>/dev/null || true
                ln -sf $(which fdfind) ~/.local/bin/fd 2>/dev/null || true
            elif command -v scoop &> /dev/null; then
                scoop install ripgrep fd bat fzf
            fi
            ;;
    esac
    
    log_success "Modern CLI tools installed!"
}

install_multiplexers() {
    log_info "Installing terminal multiplexers..."
    
    case "$OS" in
        macos)
            brew install tmux screen
            ;;
        ubuntu|debian)
            sudo apt-get install -y tmux screen
            ;;
        fedora|rhel|centos)
            if command -v dnf &> /dev/null; then
                sudo dnf install -y tmux screen
            else
                sudo yum install -y tmux screen
            fi
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm tmux screen
            ;;
        windows)
            if grep -qi microsoft /proc/version 2>/dev/null; then
                sudo apt-get install -y tmux screen
            fi
            ;;
    esac
    
    # Install TPM (Tmux Plugin Manager)
    install_tmux_plugin_manager
}

install_tmux_plugin_manager() {
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        log_info "Installing Tmux Plugin Manager..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    else
        log_info "TPM already installed"
    fi
}
