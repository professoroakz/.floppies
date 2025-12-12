#!/usr/bin/env bash

#############################################
# Hacker Essentials Installation
#############################################
# Based on Reddit (r/hacking, r/netsec, r/sysadmin),
# StackOverflow, YouTube tech channels, and "must-have" lists
# Includes: Network tools, reverse engineering, pentesting,
# system utilities, debugging, and cross-platform CLIs
#############################################

install_hacker_essentials() {
    log_info "Installing hacker essentials..."
    
    install_network_analysis_tools
    install_reverse_engineering_tools
    install_debugging_tools
    install_system_utilities
    install_cross_platform_cli_tools
    install_file_sync_tools
    
    log_success "Hacker essentials installed!"
}

#############################################
# Network Analysis Tools
#############################################

install_network_analysis_tools() {
    log_info "Installing network analysis tools..."
    
    case "$OS" in
        macos)
            # Essential network tools
            brew install nmap wireshark tcpdump netcat socat
            
            # Modern network tools
            brew install gping bandwhich dog mtr
            
            # Security scanning
            brew install masscan zmap rustscan
            
            # Packet analysis
            brew install termshark tshark
            
            # Network debugging
            brew install netsniff-ng httping iperf3
            
            # DNS tools
            brew install dnsutils bind
            ;;
        ubuntu|debian)
            sudo apt-get install -y nmap wireshark tcpdump netcat-openbsd socat
            sudo apt-get install -y mtr-tiny dnsutils bind9-dnsutils
            sudo apt-get install -y httping iperf3 tcptraceroute
            
            # Install Rust-based tools via cargo if available
            if command -v cargo &> /dev/null; then
                cargo install rustscan
                cargo install bandwhich
            fi
            ;;
        fedora|rhel|centos)
            sudo dnf install -y nmap wireshark tcpdump nmap-ncat socat
            sudo dnf install -y mtr bind-utils httping iperf3
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm nmap wireshark-qt tcpdump openbsd-netcat socat
            sudo pacman -S --noconfirm mtr bind httping iperf3
            ;;
    esac
    
    log_success "Network analysis tools installed!"
}

#############################################
# Reverse Engineering Tools
#############################################

install_reverse_engineering_tools() {
    log_info "Installing reverse engineering tools..."
    
    case "$OS" in
        macos)
            # Disassemblers and debuggers
            brew install radare2 rizin lldb gdb
            
            # Binary analysis
            brew install binutils binwalk hexyl
            
            # Decompilers
            brew install ghidra
            
            # Hex editors
            brew install hexedit
            ;;
        ubuntu|debian)
            sudo apt-get install -y radare2 gdb lldb
            sudo apt-get install -y binutils binwalk hexyl
            sudo apt-get install -y hexedit xxd
            ;;
        fedora|rhel|centos)
            sudo dnf install -y radare2 gdb binutils
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm radare2 gdb lldb binutils
            ;;
    esac
    
    log_success "Reverse engineering tools installed!"
}

#############################################
# Debugging Tools
#############################################

install_debugging_tools() {
    log_info "Installing debugging tools..."
    
    case "$OS" in
        macos)
            # System debugging
            brew install strace ltrace lsof
            
            # Process inspection
            brew install pstree psgrep
            
            # Memory debugging
            brew install valgrind
            ;;
        ubuntu|debian)
            sudo apt-get install -y strace ltrace lsof
            sudo apt-get install -y psmisc pstree
            sudo apt-get install -y valgrind gdb
            ;;
        fedora|rhel|centos)
            sudo dnf install -y strace ltrace lsof psmisc valgrind
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm strace ltrace lsof psmisc valgrind
            ;;
    esac
    
    log_success "Debugging tools installed!"
}

#############################################
# System Utilities
#############################################

install_system_utilities() {
    log_info "Installing system utilities..."
    
    case "$OS" in
        macos)
            # Process management
            brew install pgrep pkill killall
            
            # System monitoring
            brew install htop bottom vtop
            
            # Disk tools
            brew install ncdu duf dust
            
            # File searching
            brew install fd ripgrep ag the_silver_searcher
            
            # Archive tools
            brew install p7zip xz unrar pigz pv
            
            # Terminal multiplexers
            brew install tmux screen byobu
            
            # Modern alternatives
            brew install exa bat
            ;;
        ubuntu|debian)
            sudo apt-get install -y htop ncdu pv pigz
            sudo apt-get install -y p7zip-full xz-utils unrar
            sudo apt-get install -y tmux screen byobu
            sudo apt-get install -y silversearcher-ag
            
            # Rust-based modern tools
            if command -v cargo &> /dev/null; then
                cargo install bottom fd-find ripgrep bat exa dust duf
            fi
            ;;
        fedora|rhel|centos)
            sudo dnf install -y htop ncdu pv pigz
            sudo dnf install -y p7zip p7zip-plugins xz unrar
            sudo dnf install -y tmux screen
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm htop ncdu pv pigz
            sudo pacman -S --noconfirm p7zip xz unrar tmux screen
            sudo pacman -S --noconfirm fd ripgrep bat exa
            ;;
    esac
    
    log_success "System utilities installed!"
}

#############################################
# Cross-Platform CLI Tools
#############################################

install_cross_platform_cli_tools() {
    log_info "Installing cross-platform CLI tools..."
    
    case "$OS" in
        macos)
            # File transfer
            brew install rsync rclone croc
            
            # Text processing
            brew install jq yq fx gron
            
            # Terminal enhancements
            brew install asciinema tmux-cssh
            
            # Code tools
            brew install cloc tokei scc
            
            # Benchmark tools
            brew install hyperfine pv
            
            # Modern Unix tools
            brew install choose sd xsv
            ;;
        ubuntu|debian)
            sudo apt-get install -y rsync jq pv cloc
            
            # Install via cargo if available
            if command -v cargo &> /dev/null; then
                cargo install tokei scc hyperfine choose sd xsv
            fi
            
            # Install rclone
            if ! command -v rclone &> /dev/null; then
                curl https://rclone.org/install.sh | sudo bash
            fi
            ;;
        fedora|rhel|centos)
            sudo dnf install -y rsync jq pv cloc
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm rsync jq pv cloc
            sudo pacman -S --noconfirm tokei hyperfine
            ;;
    esac
    
    log_success "Cross-platform CLI tools installed!"
}

#############################################
# File Sync Tools
#############################################

install_file_sync_tools() {
    log_info "Installing file sync tools..."
    
    case "$OS" in
        macos)
            # Syncthing (P2P file sync)
            brew install syncthing
            
            # Rclone (cloud sync)
            brew install rclone
            
            # Git-based sync
            brew install git-lfs
            ;;
        ubuntu|debian)
            # Syncthing
            if ! command -v syncthing &> /dev/null; then
                curl -s https://syncthing.net/release-key.txt | sudo gpg --dearmor -o /usr/share/keyrings/syncthing-archive-keyring.gpg
                echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
                sudo apt-get update
                sudo apt-get install -y syncthing
            fi
            
            # Git LFS
            sudo apt-get install -y git-lfs
            git lfs install
            ;;
        fedora|rhel|centos)
            sudo dnf install -y git-lfs
            git lfs install
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm syncthing git-lfs
            git lfs install
            ;;
    esac
    
    log_success "File sync tools installed!"
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_hacker_essentials
fi
