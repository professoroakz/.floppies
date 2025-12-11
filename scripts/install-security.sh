#!/usr/bin/env bash

#############################################
# Security Tools Installation
#############################################

install_security_tools() {
    log_info "Installing security tools..."
    
    case "$OS" in
        macos)
            brew install nmap netcat socat tcpdump wireshark
            brew install hashcat john-jumbo hydra sqlmap
            brew install aircrack-ng
            brew install gnupg
            brew install pass
            ;;
        ubuntu|debian)
            sudo apt-get install -y nmap netcat socat tcpdump wireshark
            sudo apt-get install -y hashcat john hydra sqlmap
            sudo apt-get install -y aircrack-ng
            sudo apt-get install -y gnupg2
            sudo apt-get install -y pass
            ;;
        fedora|rhel|centos)
            if command -v dnf &> /dev/null; then
                sudo dnf install -y nmap nmap-ncat socat tcpdump wireshark
                sudo dnf install -y hashcat john hydra sqlmap
                sudo dnf install -y aircrack-ng
                sudo dnf install -y gnupg2
            else
                sudo yum install -y nmap nc socat tcpdump wireshark
                sudo yum install -y hashcat john hydra sqlmap
                sudo yum install -y aircrack-ng
                sudo yum install -y gnupg2
            fi
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm nmap openbsd-netcat socat tcpdump wireshark-qt
            sudo pacman -S --noconfirm hashcat john hydra sqlmap
            sudo pacman -S --noconfirm aircrack-ng
            sudo pacman -S --noconfirm gnupg
            ;;
    esac
    
    log_success "Security tools installed!"
}
