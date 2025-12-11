#!/usr/bin/env bash

#############################################
# Editors and IDEs Installation
#############################################

install_editors() {
    log_info "Installing editors and IDEs..."
    
    install_vscode
    install_vim_neovim
    
    log_success "Editors installed!"
}

install_vscode() {
    log_info "Installing Visual Studio Code..."
    
    case "$OS" in
        macos)
            if ! brew list --cask visual-studio-code &> /dev/null; then
                brew install --cask visual-studio-code
            else
                log_info "VSCode already installed"
            fi
            ;;
        ubuntu|debian)
            if ! command -v code &> /dev/null; then
                wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
                sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
                sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
                rm -f packages.microsoft.gpg
                sudo apt-get update
                sudo apt-get install -y code
            else
                log_info "VSCode already installed"
            fi
            ;;
        fedora|rhel|centos)
            if ! command -v code &> /dev/null; then
                sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
                sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
                if command -v dnf &> /dev/null; then
                    sudo dnf install -y code
                else
                    sudo yum install -y code
                fi
            else
                log_info "VSCode already installed"
            fi
            ;;
        arch|manjaro)
            if ! command -v code &> /dev/null; then
                sudo pacman -S --noconfirm code
            else
                log_info "VSCode already installed"
            fi
            ;;
        windows)
            if grep -qi microsoft /proc/version 2>/dev/null; then
                log_info "WSL detected. Install VSCode on Windows host."
                log_info "Download from: https://code.visualstudio.com/"
            elif command -v choco &> /dev/null; then
                choco install -y vscode
            elif command -v scoop &> /dev/null; then
                scoop bucket add extras
                scoop install vscode
            fi
            ;;
    esac
    
    # Install VSCode extensions
    install_vscode_extensions
}

install_vscode_extensions() {
    if ! command -v code &> /dev/null; then
        log_warning "VSCode not found in PATH. Skipping extensions."
        return
    fi
    
    log_info "Installing VSCode extensions..."
    
    # Essential extensions
    local extensions=(
        "ms-python.python"
        "ms-vscode.cpptools"
        "ms-azuretools.vscode-docker"
        "esbenp.prettier-vscode"
        "dbaeumer.vscode-eslint"
        "eamodio.gitlens"
        "ms-vscode-remote.remote-ssh"
        "ms-vscode-remote.remote-wsl"
        "ms-vscode-remote.remote-containers"
        "ms-vscode.remote-explorer"
        "GitHub.copilot"
        "GitHub.copilot-chat"
        "rust-lang.rust-analyzer"
        "golang.go"
        "rebornix.ruby"
        "bmewburn.vscode-intelephense-client"
        "ms-toolsai.jupyter"
        "ms-kubernetes-tools.vscode-kubernetes-tools"
        "hashicorp.terraform"
        "redhat.vscode-yaml"
        "ms-vscode.makefile-tools"
        "ms-vscode.cmake-tools"
        "bradlc.vscode-tailwindcss"
        "dsznajder.es7-react-js-snippets"
        "christian-kohler.path-intellisense"
        "formulahendry.auto-rename-tag"
        "streetsidesoftware.code-spell-checker"
    )
    
    for extension in "${extensions[@]}"; do
        if code --list-extensions | grep -q "$extension"; then
            log_info "Extension $extension already installed"
        else
            log_info "Installing extension: $extension"
            code --install-extension "$extension" --force || log_warning "Failed to install $extension"
        fi
    done
    
    log_success "VSCode extensions installed!"
}

install_vim_neovim() {
    log_info "Installing Vim/Neovim..."
    
    case "$OS" in
        macos)
            brew install vim
            brew install neovim
            ;;
        ubuntu|debian)
            sudo apt-get install -y vim neovim
            ;;
        fedora|rhel|centos)
            if command -v dnf &> /dev/null; then
                sudo dnf install -y vim neovim
            else
                sudo yum install -y vim neovim
            fi
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm vim neovim
            ;;
        windows)
            if grep -qi microsoft /proc/version 2>/dev/null; then
                sudo apt-get install -y vim neovim
            elif command -v scoop &> /dev/null; then
                scoop install vim neovim
            fi
            ;;
    esac
    
    # Install vim-plug for plugin management
    install_vim_plug
}

install_vim_plug() {
    log_info "Installing vim-plug..."
    
    # For Vim
    if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
    
    # For Neovim
    if [ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" ]; then
        sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    fi
    
    log_success "vim-plug installed!"
}
