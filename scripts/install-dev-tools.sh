#!/usr/bin/env bash

#############################################
# Development Tools Installation
#############################################

install_dev_tools() {
    log_info "Installing development tools..."
    
    case "$OS" in
        macos)
            install_dev_tools_macos
            ;;
        ubuntu|debian)
            install_dev_tools_debian
            ;;
        fedora|rhel|centos)
            install_dev_tools_redhat
            ;;
        arch|manjaro)
            install_dev_tools_arch
            ;;
        windows)
            install_dev_tools_windows
            ;;
    esac
    
    # Install language-specific tools (cross-platform)
    install_nodejs
    install_python
    install_ruby
    install_rust
    install_go
    
    log_success "Development tools installed!"
}

install_dev_tools_macos() {
    log_info "Installing development tools for macOS..."
    
    # Install Xcode Command Line Tools if not present
    if ! xcode-select -p &> /dev/null; then
        log_info "Installing Xcode Command Line Tools..."
        xcode-select --install
    fi
    
    # Programming languages and tools
    brew install node
    brew install python@3.12
    brew install ruby
    brew install go
    brew install rust
    brew install java
    
    # Build tools
    brew install cmake
    brew install make
    brew install gcc
    
    # Database tools
    brew install postgresql
    brew install mysql
    brew install redis
    brew install mongodb-community || true
    
    log_success "macOS development tools installed!"
}

install_dev_tools_debian() {
    log_info "Installing development tools for Debian/Ubuntu..."
    
    # Programming languages
    sudo apt-get install -y \
        nodejs \
        npm \
        python3 \
        python3-pip \
        python3-venv \
        ruby \
        ruby-dev \
        default-jdk
    
    # Build tools
    sudo apt-get install -y \
        cmake \
        make \
        gcc \
        g++
    
    # Database tools
    sudo apt-get install -y \
        postgresql \
        postgresql-contrib \
        mysql-server \
        redis-server || true
    
    log_success "Debian/Ubuntu development tools installed!"
}

install_dev_tools_redhat() {
    log_info "Installing development tools for RHEL/Fedora..."
    
    if command -v dnf &> /dev/null; then
        PKG_MGR="dnf"
    else
        PKG_MGR="yum"
    fi
    
    # Development group
    sudo $PKG_MGR groupinstall -y "Development Tools"
    
    # Programming languages
    sudo $PKG_MGR install -y \
        nodejs \
        npm \
        python3 \
        python3-pip \
        ruby \
        ruby-devel \
        java-11-openjdk-devel
    
    # Database tools
    sudo $PKG_MGR install -y \
        postgresql \
        postgresql-server \
        mysql-server \
        redis || true
    
    log_success "RHEL/Fedora development tools installed!"
}

install_dev_tools_arch() {
    log_info "Installing development tools for Arch Linux..."
    
    # Programming languages
    sudo pacman -S --noconfirm \
        nodejs \
        npm \
        python \
        python-pip \
        ruby \
        jdk-openjdk
    
    # Build tools
    sudo pacman -S --noconfirm \
        cmake \
        make \
        gcc
    
    # Database tools
    sudo pacman -S --noconfirm \
        postgresql \
        mysql \
        redis || true
    
    log_success "Arch Linux development tools installed!"
}

install_dev_tools_windows() {
    log_info "Installing development tools for Windows..."
    
    if grep -qi microsoft /proc/version 2>/dev/null; then
        # WSL - use Linux package manager
        install_dev_tools_debian
        return
    fi
    
    # Install via Scoop or Chocolatey
    if command -v scoop &> /dev/null; then
        scoop bucket add extras
        scoop bucket add java
        scoop install nodejs python ruby go rust
    elif command -v choco &> /dev/null; then
        choco install -y nodejs python ruby golang rust
    fi
    
    log_success "Windows development tools installed!"
}

install_nodejs() {
    log_info "Configuring Node.js environment..."
    
    # Install nvm (Node Version Manager) if not present
    if [ ! -d "$HOME/.nvm" ]; then
        log_info "Installing nvm..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
        
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        
        # Install latest LTS
        nvm install --lts
        nvm use --lts
    fi
    
    # Install global packages
    if command -v npm &> /dev/null; then
        log_info "Installing global npm packages..."
        npm install -g yarn
        npm install -g pnpm
        npm install -g typescript
        npm install -g ts-node
        npm install -g eslint
        npm install -g prettier
        npm install -g npm-check-updates
    fi
}

install_python() {
    log_info "Configuring Python environment..."
    
    # Install pyenv if not present
    if [ ! -d "$HOME/.pyenv" ]; then
        log_info "Installing pyenv..."
        curl https://pyenv.run | bash
    fi
    
    # Install common Python packages
    if command -v pip3 &> /dev/null; then
        log_info "Installing Python packages..."
        pip3 install --user --upgrade pip
        pip3 install --user virtualenv
        pip3 install --user pipenv
        pip3 install --user poetry
        pip3 install --user black
        pip3 install --user flake8
        pip3 install --user pylint
        pip3 install --user pytest
    fi
}

install_ruby() {
    log_info "Configuring Ruby environment..."
    
    # Install rbenv if not present
    if [ ! -d "$HOME/.rbenv" ]; then
        log_info "Installing rbenv..."
        curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
    fi
    
    # Install common gems
    if command -v gem &> /dev/null; then
        log_info "Installing Ruby gems..."
        gem install bundler
        gem install rake
        gem install rspec
    fi
}

install_rust() {
    log_info "Configuring Rust environment..."
    
    # Install rustup if not present
    if ! command -v rustup &> /dev/null; then
        log_info "Installing Rust via rustup..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
    fi
}

install_go() {
    log_info "Configuring Go environment..."
    
    # Go is typically installed via package manager
    # Just set up the workspace
    if command -v go &> /dev/null; then
        mkdir -p "$HOME/go"/{bin,src,pkg}
        export GOPATH="$HOME/go"
        export PATH="$PATH:$GOPATH/bin"
    fi
}
