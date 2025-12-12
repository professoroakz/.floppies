#!/usr/bin/env bash

#############################################
# .floppies - Universal Dev Environment Setup
#############################################
# One script to rule them all
# Supports: macOS, Linux (Ubuntu/Debian/RHEL/Arch), Windows (WSL/Git Bash)
#############################################

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            OS=$ID
            OS_VERSION=$VERSION_ID
        else
            OS="linux"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
        OS="windows"
    else
        OS="unknown"
    fi
    
    log_info "Detected OS: $OS"
}

# Check if running with sudo/admin privileges
check_privileges() {
    if [[ "$OS" != "windows" ]]; then
        if [[ $EUID -eq 0 ]]; then
            log_warning "Running as root. This script should be run as a regular user."
            log_warning "It will prompt for sudo when needed."
            return 1
        fi
    fi
    return 0
}

# Main installation menu
show_menu() {
    echo ""
    echo "=================================="
    echo "  .floppies Installation Menu"
    echo "=================================="
    echo "1. Full Installation (Recommended)"
    echo "2. Core Essentials Only"
    echo "3. Custom Installation"
    echo "4. Update Existing Installation"
    echo "5. Uninstall"
    echo "0. Exit"
    echo "=================================="
    echo -n "Select an option: "
}

# Core essentials installation
install_core() {
    log_info "Installing core essentials..."
    
    # Source OS-specific installation script
    case "$OS" in
        macos)
            source "$SCRIPT_DIR/scripts/install-macos.sh"
            install_core_macos
            ;;
        ubuntu|debian)
            source "$SCRIPT_DIR/scripts/install-linux.sh"
            install_core_linux
            ;;
        fedora|rhel|centos)
            source "$SCRIPT_DIR/scripts/install-linux.sh"
            install_core_linux
            ;;
        arch|manjaro)
            source "$SCRIPT_DIR/scripts/install-linux.sh"
            install_core_linux
            ;;
        windows)
            source "$SCRIPT_DIR/scripts/install-windows.sh"
            install_core_windows
            ;;
        *)
            log_error "Unsupported OS: $OS"
            exit 1
            ;;
    esac
    
    log_success "Core essentials installed!"
}

# Full installation
install_full() {
    log_info "Starting full installation..."
    
    install_core
    
    # Install development tools
    source "$SCRIPT_DIR/scripts/install-dev-tools.sh"
    install_dev_tools
    
    # Install editors
    source "$SCRIPT_DIR/scripts/install-editors.sh"
    install_editors
    
    # Install terminal tools
    source "$SCRIPT_DIR/scripts/install-terminal.sh"
    install_terminal_tools
    
    # Install terminal emulators
    source "$SCRIPT_DIR/scripts/install-terminals.sh"
    install_terminal_emulators
    install_color_schemes
    configure_random_colors
    
    # Install container tools
    source "$SCRIPT_DIR/scripts/install-containers.sh"
    install_containers
    
    # Install productivity tools
    source "$SCRIPT_DIR/scripts/install-productivity.sh"
    install_productivity_tools
    
    # Install community favorites
    source "$SCRIPT_DIR/scripts/install-community-favorites.sh"
    install_community_favorites
    
    # Install macOS Shortcuts (macOS only)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        source "$SCRIPT_DIR/scripts/install-macos-shortcuts.sh"
    fi
    
    # Configure dotfiles
    source "$SCRIPT_DIR/scripts/configure-dotfiles.sh"
    configure_dotfiles
    
    log_success "Full installation completed!"
}

# Custom installation menu
custom_installation() {
    echo ""
    echo "=================================="
    echo "  Custom Installation"
    echo "=================================="
    echo "Select components to install:"
    echo "1. Development Tools (Git, Node.js, Python, etc.)"
    echo "2. Editors (VSCode, Vim)"
    echo "3. Terminal Tools (tmux, modern CLI tools)"
    echo "4. Terminal Emulators (iTerm2, Warp, color schemes)"
    echo "5. Container Tools (Docker, Kubernetes)"
    echo "6. Security Tools"
    echo "7. Data Science Tools"
    echo "8. Cloud Tools (AWS, Azure, GCP)"
    echo "9. Productivity Tools (AI CLIs, notes, todos, communication)"
    echo "10. Programming Fonts (Fira Code, JetBrains Mono, Nerd Fonts)"
    echo "11. Shell Enhancements (thefuck, autojump, direnv, mosh)"
    echo "12. Community Favorites (lazygit, btop++, ranger, lf, eza, zoxide)"
    echo "13. Hacker Essentials (nmap, radare2, strace, tcpdump, network tools)"
    echo "14. macOS Shortcuts Integration (automate terminal workflows)"
    echo "15. Dotfiles Configuration"
    echo "0. Back to main menu"
    echo "=================================="
    echo -n "Select options (comma-separated, e.g., 1,2,3): "
    
    read -r selections
    
    IFS=',' read -ra SELECTED <<< "$selections"
    for selection in "${SELECTED[@]}"; do
        case $selection in
            1)
                source "$SCRIPT_DIR/scripts/install-dev-tools.sh"
                install_dev_tools
                ;;
            2)
                source "$SCRIPT_DIR/scripts/install-editors.sh"
                install_editors
                ;;
            3)
                source "$SCRIPT_DIR/scripts/install-terminal.sh"
                install_terminal_tools
                ;;
            4)
                source "$SCRIPT_DIR/scripts/install-terminals.sh"
                install_terminal_emulators
                install_color_schemes
                configure_random_colors
                ;;
            5)
                source "$SCRIPT_DIR/scripts/install-containers.sh"
                install_containers
                ;;
            6)
                source "$SCRIPT_DIR/scripts/install-security.sh"
                install_security_tools
                ;;
            7)
                source "$SCRIPT_DIR/scripts/install-datascience.sh"
                install_datascience_tools
                ;;
            8)
                source "$SCRIPT_DIR/scripts/install-cloud.sh"
                install_cloud_tools
                ;;
            9)
                source "$SCRIPT_DIR/scripts/install-productivity.sh"
                install_productivity_tools
                ;;
            10)
                source "$SCRIPT_DIR/scripts/install-fonts.sh"
                install_fonts
                ;;
            11)
                source "$SCRIPT_DIR/scripts/install-shell-enhancements.sh"
                install_shell_enhancements
                ;;
            12)
                source "$SCRIPT_DIR/scripts/install-community-favorites.sh"
                install_community_favorites
                ;;
            13)
                source "$SCRIPT_DIR/scripts/install-hacker-essentials.sh"
                install_hacker_essentials
                ;;
            14)
                if [[ "$OSTYPE" == "darwin"* ]]; then
                    source "$SCRIPT_DIR/scripts/install-macos-shortcuts.sh"
                else
                    log_warning "macOS Shortcuts integration is only available on macOS"
                fi
                ;;
            15)
                source "$SCRIPT_DIR/scripts/configure-dotfiles.sh"
                configure_dotfiles
                ;;
            0)
                return
                ;;
            *)
                log_warning "Invalid selection: $selection"
                ;;
        esac
    done
    
    log_success "Custom installation completed!"
}

# Update existing installation
update_installation() {
    log_info "Updating .floppies installation..."
    
    # Pull latest changes
    cd "$SCRIPT_DIR"
    if [ -d .git ]; then
        git pull origin main
    fi
    
    # Re-run installation
    log_info "Re-running installation to update components..."
    install_full
    
    log_success "Update completed!"
}

# Uninstall
uninstall() {
    log_warning "This will remove .floppies and optionally remove installed packages."
    echo -n "Are you sure you want to continue? (y/N): "
    read -r response
    
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        log_info "Uninstall cancelled."
        return
    fi
    
    source "$SCRIPT_DIR/scripts/uninstall.sh"
    perform_uninstall
    
    log_success "Uninstall completed!"
}

# Main function
main() {
    echo ""
    echo "╔═══════════════════════════════════════╗"
    echo "║     .floppies - Dev Setup v1.0        ║"
    echo "║  Universal Development Environment    ║"
    echo "╚═══════════════════════════════════════╝"
    echo ""
    
    detect_os
    check_privileges
    
    while true; do
        show_menu
        read -r choice
        
        case $choice in
            1)
                install_full
                break
                ;;
            2)
                install_core
                break
                ;;
            3)
                custom_installation
                ;;
            4)
                update_installation
                break
                ;;
            5)
                uninstall
                break
                ;;
            0)
                log_info "Exiting..."
                exit 0
                ;;
            *)
                log_error "Invalid option. Please try again."
                ;;
        esac
    done
    
    echo ""
    log_success "Thank you for using .floppies!"
    echo ""
    log_info "Please restart your terminal or run: source ~/.bash_profile (or ~/.zshrc)"
}

# Run main
main "$@"
