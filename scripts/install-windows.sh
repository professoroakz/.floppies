#!/usr/bin/env bash

#############################################
# Windows-specific installation functions
#############################################

install_core_windows() {
    log_info "Installing core essentials for Windows..."
    
    # Check if running in WSL
    if grep -qi microsoft /proc/version 2>/dev/null; then
        log_info "Detected WSL environment"
        install_core_wsl
        return
    fi
    
    # Check if Chocolatey is installed
    if ! command -v choco &> /dev/null; then
        log_info "Chocolatey not found. Attempting to install..."
        log_warning "Please run PowerShell as Administrator and execute:"
        echo "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
        log_warning "After installing Chocolatey, re-run this script."
        return 1
    fi
    
    # Check if Scoop is installed (alternative to Chocolatey)
    if ! command -v scoop &> /dev/null; then
        log_info "Installing Scoop..."
        powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; iwr -useb get.scoop.sh | iex"
    fi
    
    # Install essential packages via Scoop
    log_info "Installing essential packages..."
    
    scoop install git
    scoop install curl
    scoop install wget
    scoop install openssh
    scoop install vim
    
    # Install via Chocolatey if available
    if command -v choco &> /dev/null; then
        choco install -y git
        choco install -y curl
        choco install -y wget
        choco install -y vim
        choco install -y 7zip
    fi
    
    log_success "Core essentials for Windows installed!"
}

install_core_wsl() {
    log_info "Installing packages for WSL..."
    
    # WSL typically runs Ubuntu, so use apt
    sudo apt-get update
    
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
        xz-utils \
        unzip \
        zip
    
    # Install wslu for WSL utilities
    sudo apt-get install -y ubuntu-wsl || true
    
    log_success "WSL core packages installed!"
}

install_chocolatey_packages() {
    local packages=("$@")
    
    if ! command -v choco &> /dev/null; then
        log_warning "Chocolatey not installed. Skipping package installation."
        return 1
    fi
    
    for package in "${packages[@]}"; do
        log_info "Installing $package..."
        choco install -y "$package"
    done
}

install_scoop_packages() {
    local packages=("$@")
    
    if ! command -v scoop &> /dev/null; then
        log_warning "Scoop not installed. Skipping package installation."
        return 1
    fi
    
    for package in "${packages[@]}"; do
        log_info "Installing $package..."
        scoop install "$package"
    done
}
