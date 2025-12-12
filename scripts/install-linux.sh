#!/usr/bin/env bash

#############################################
# Linux-specific installation functions
#############################################

install_core_linux() {
    log_info "Installing core essentials for Linux ($OS)..."
    
    case "$OS" in
        ubuntu|debian)
            install_core_debian
            ;;
        fedora|rhel|centos)
            install_core_redhat
            ;;
        arch|manjaro)
            install_core_arch
            ;;
        *)
            log_error "Unsupported Linux distribution: $OS"
            return 1
            ;;
    esac
    
    log_success "Core essentials for Linux installed!"
}

install_core_debian() {
    log_info "Installing packages for Debian/Ubuntu..."
    
    sudo apt-get update
    
    # Essential packages
    sudo apt-get install -y \
        build-essential \
        curl \
        wget \
        git \
        git-lfs \
        vim \
        zsh \
        tmux \
        ssh \
        gnupg \
        ca-certificates \
        apt-transport-https \
        software-properties-common \
        xz-utils \
        unzip \
        zip
    
    log_success "Debian/Ubuntu core packages installed!"
}

install_core_redhat() {
    log_info "Installing packages for RHEL/Fedora/CentOS..."
    
    # Determine package manager
    if command -v dnf &> /dev/null; then
        PKG_MGR="dnf"
    else
        PKG_MGR="yum"
    fi
    
    sudo $PKG_MGR update -y
    
    # Essential packages
    sudo $PKG_MGR install -y \
        gcc \
        gcc-c++ \
        make \
        curl \
        wget \
        git \
        git-lfs \
        vim \
        zsh \
        tmux \
        openssh \
        gnupg2 \
        ca-certificates \
        xz \
        unzip \
        zip
    
    # Enable EPEL repository for additional packages
    if [[ "$OS" == "rhel" || "$OS" == "centos" ]]; then
        sudo $PKG_MGR install -y epel-release
    fi
    
    log_success "RHEL/Fedora/CentOS core packages installed!"
}

install_core_arch() {
    log_info "Installing packages for Arch Linux..."
    
    sudo pacman -Syu --noconfirm
    
    # Essential packages
    sudo pacman -S --noconfirm \
        base-devel \
        curl \
        wget \
        git \
        git-lfs \
        vim \
        zsh \
        tmux \
        openssh \
        gnupg \
        xz \
        unzip \
        zip
    
    log_success "Arch Linux core packages installed!"
}

install_apt_packages() {
    local packages=("$@")
    
    for package in "${packages[@]}"; do
        if dpkg -l | grep -q "^ii  $package "; then
            log_info "$package is already installed"
        else
            log_info "Installing $package..."
            sudo apt-get install -y "$package"
        fi
    done
}
