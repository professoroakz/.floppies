#!/usr/bin/env bash

#############################################
# Community Favorites Module
# Based on Reddit, YouTube, and awesome lists
# Tools that power users can't live without
#############################################

install_community_favorites() {
    log_info "Installing community favorite tools..."
    
    # File managers and navigation
    install_file_managers
    
    # System monitoring and process management
    install_system_monitors
    
    # Git enhancements
    install_git_tools
    
    # Text processing and editing
    install_text_tools
    
    # Network and download tools
    install_network_tools
    
    # Archive and compression
    install_archive_tools
    
    # Miscellaneous essentials
    install_misc_essentials
    
    log_success "Community favorite tools installed!"
}

install_file_managers() {
    log_info "Installing file managers..."
    
    # lf (terminal file manager, successor to ranger)
    if ! command -v lf &>/dev/null; then
        log_info "Installing lf..."
        case "$OS" in
            macos)
                brew install lf
                ;;
            ubuntu|debian)
                # Install from GitHub releases
                LF_VERSION=$(curl -s https://api.github.com/repos/gokcehan/lf/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
                if [ -n "$LF_VERSION" ]; then
                    wget -q "https://github.com/gokcehan/lf/releases/download/${LF_VERSION}/lf-linux-amd64.tar.gz" -O /tmp/lf.tar.gz
                    tar xf /tmp/lf.tar.gz -C /tmp
                    sudo mv /tmp/lf /usr/local/bin/
                    rm /tmp/lf.tar.gz
                fi
                ;;
            fedora|rhel|centos)
                sudo dnf install -y lf || {
                    LF_VERSION=$(curl -s https://api.github.com/repos/gokcehan/lf/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
                    if [ -n "$LF_VERSION" ]; then
                        wget -q "https://github.com/gokcehan/lf/releases/download/${LF_VERSION}/lf-linux-amd64.tar.gz" -O /tmp/lf.tar.gz
                        tar xf /tmp/lf.tar.gz -C /tmp
                        sudo mv /tmp/lf /usr/local/bin/
                        rm /tmp/lf.tar.gz
                    fi
                }
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm lf
                ;;
        esac
    fi
    
    # ranger (Python file manager)
    if ! command -v ranger &>/dev/null; then
        log_info "Installing ranger..."
        case "$OS" in
            macos)
                brew install ranger
                ;;
            ubuntu|debian|fedora|rhel|centos)
                pip3 install --user ranger-fm
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm ranger
                ;;
        esac
    fi
    
    # nnn (blazing fast file manager)
    if ! command -v nnn &>/dev/null; then
        log_info "Installing nnn..."
        case "$OS" in
            macos)
                brew install nnn
                ;;
            ubuntu|debian)
                sudo apt-get install -y nnn
                ;;
            fedora|rhel|centos)
                sudo dnf install -y nnn
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm nnn
                ;;
        esac
    fi
    
    # broot (tree view with fuzzy search)
    if ! command -v broot &>/dev/null; then
        log_info "Installing broot..."
        case "$OS" in
            macos)
                brew install broot
                ;;
            *)
                cargo install broot 2>/dev/null || log_warn "broot requires Rust/cargo"
                ;;
        esac
    fi
}

install_system_monitors() {
    log_info "Installing system monitors..."
    
    # btop++ (beautiful modern resource monitor)
    if ! command -v btop &>/dev/null; then
        log_info "Installing btop++..."
        case "$OS" in
            macos)
                brew install btop
                ;;
            ubuntu|debian)
                sudo apt-get install -y btop || {
                    # Fallback to snap if not in apt
                    sudo snap install btop 2>/dev/null || log_warn "btop not available"
                }
                ;;
            fedora|rhel|centos)
                sudo dnf install -y btop
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm btop
                ;;
        esac
    fi
    
    # glances (cross-platform monitoring)
    if ! command -v glances &>/dev/null; then
        log_info "Installing glances..."
        case "$OS" in
            macos)
                brew install glances
                ;;
            ubuntu|debian)
                sudo apt-get install -y glances
                ;;
            fedora|rhel|centos)
                sudo dnf install -y glances
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm glances
                ;;
        esac
    fi
    
    # procs (modern ps replacement)
    if ! command -v procs &>/dev/null; then
        log_info "Installing procs..."
        case "$OS" in
            macos)
                brew install procs
                ;;
            *)
                cargo install procs 2>/dev/null || log_warn "procs requires Rust/cargo"
                ;;
        esac
    fi
    
    # duf (modern df replacement)
    if ! command -v duf &>/dev/null; then
        log_info "Installing duf..."
        case "$OS" in
            macos)
                brew install duf
                ;;
            ubuntu|debian)
                sudo apt-get install -y duf || {
                    DUF_VERSION=$(curl -s https://api.github.com/repos/muesli/duf/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
                    if [ -n "$DUF_VERSION" ]; then
                        wget -q "https://github.com/muesli/duf/releases/download/${DUF_VERSION}/duf_${DUF_VERSION#v}_linux_amd64.deb" -O /tmp/duf.deb
                        sudo dpkg -i /tmp/duf.deb
                        rm /tmp/duf.deb
                    fi
                }
                ;;
            fedora|rhel|centos)
                sudo dnf install -y duf
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm duf
                ;;
        esac
    fi
    
    # dust (du + rust)
    if ! command -v dust &>/dev/null; then
        log_info "Installing dust..."
        case "$OS" in
            macos)
                brew install dust
                ;;
            *)
                cargo install du-dust 2>/dev/null || log_warn "dust requires Rust/cargo"
                ;;
        esac
    fi
}

install_git_tools() {
    log_info "Installing git enhancement tools..."
    
    # lazygit (simple terminal UI for git)
    if ! command -v lazygit &>/dev/null; then
        log_info "Installing lazygit..."
        case "$OS" in
            macos)
                brew install lazygit
                ;;
            ubuntu|debian)
                LAZYGIT_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
                if [ -n "$LAZYGIT_VERSION" ]; then
                    wget -q "https://github.com/jesseduffield/lazygit/releases/download/${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION#v}_Linux_x86_64.tar.gz" -O /tmp/lazygit.tar.gz
                    tar xf /tmp/lazygit.tar.gz -C /tmp
                    sudo mv /tmp/lazygit /usr/local/bin/
                    rm /tmp/lazygit.tar.gz
                fi
                ;;
            fedora|rhel|centos)
                sudo dnf copr enable atim/lazygit -y
                sudo dnf install -y lazygit
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm lazygit
                ;;
        esac
    fi
    
    # tig (text-mode interface for git)
    if ! command -v tig &>/dev/null; then
        log_info "Installing tig..."
        case "$OS" in
            macos)
                brew install tig
                ;;
            ubuntu|debian)
                sudo apt-get install -y tig
                ;;
            fedora|rhel|centos)
                sudo dnf install -y tig
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm tig
                ;;
        esac
    fi
    
    # gh (GitHub CLI)
    if ! command -v gh &>/dev/null; then
        log_info "Installing GitHub CLI..."
        case "$OS" in
            macos)
                brew install gh
                ;;
            ubuntu|debian)
                curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
                sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
                echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
                sudo apt-get update
                sudo apt-get install -y gh
                ;;
            fedora|rhel|centos)
                sudo dnf install -y gh
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm github-cli
                ;;
        esac
    fi
    
    # delta (syntax-highlighting pager for git)
    if ! command -v delta &>/dev/null; then
        log_info "Installing git-delta..."
        case "$OS" in
            macos)
                brew install git-delta
                ;;
            ubuntu|debian)
                DELTA_VERSION=$(curl -s https://api.github.com/repos/dandavison/delta/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
                if [ -n "$DELTA_VERSION" ]; then
                    wget -q "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb" -O /tmp/delta.deb
                    sudo dpkg -i /tmp/delta.deb
                    rm /tmp/delta.deb
                fi
                ;;
            fedora|rhel|centos)
                sudo dnf install -y git-delta
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm git-delta
                ;;
        esac
    fi
}

install_text_tools() {
    log_info "Installing text processing tools..."
    
    # sd (modern sed alternative)
    if ! command -v sd &>/dev/null; then
        log_info "Installing sd..."
        case "$OS" in
            macos)
                brew install sd
                ;;
            *)
                cargo install sd 2>/dev/null || log_warn "sd requires Rust/cargo"
                ;;
        esac
    fi
    
    # choose (modern cut/awk alternative)
    if ! command -v choose &>/dev/null; then
        log_info "Installing choose..."
        cargo install choose 2>/dev/null || log_warn "choose requires Rust/cargo"
    fi
    
    # difftastic (semantic diff tool)
    if ! command -v difft &>/dev/null; then
        log_info "Installing difftastic..."
        case "$OS" in
            macos)
                brew install difftastic
                ;;
            *)
                cargo install difftastic 2>/dev/null || log_warn "difftastic requires Rust/cargo"
                ;;
        esac
    fi
    
    # eza (modern exa/ls alternative)
    if ! command -v eza &>/dev/null && ! command -v exa &>/dev/null; then
        log_info "Installing eza..."
        case "$OS" in
            macos)
                brew install eza
                ;;
            ubuntu|debian)
                sudo apt-get install -y eza || {
                    cargo install eza 2>/dev/null || log_warn "eza requires Rust/cargo"
                }
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm eza
                ;;
            *)
                cargo install eza 2>/dev/null || log_warn "eza requires Rust/cargo"
                ;;
        esac
    fi
}

install_network_tools() {
    log_info "Installing network tools..."
    
    # gping (ping with graph)
    if ! command -v gping &>/dev/null; then
        log_info "Installing gping..."
        case "$OS" in
            macos)
                brew install gping
                ;;
            *)
                cargo install gping 2>/dev/null || log_warn "gping requires Rust/cargo"
                ;;
        esac
    fi
    
    # bandwhich (network bandwidth monitor)
    if ! command -v bandwhich &>/dev/null; then
        log_info "Installing bandwhich..."
        case "$OS" in
            macos)
                brew install bandwhich
                ;;
            *)
                cargo install bandwhich 2>/dev/null || log_warn "bandwhich requires Rust/cargo"
                ;;
        esac
    fi
    
    # dog (modern dig alternative)
    if ! command -v dog &>/dev/null; then
        log_info "Installing dog..."
        case "$OS" in
            macos)
                brew install dog
                ;;
            ubuntu|debian)
                DOG_VERSION=$(curl -s https://api.github.com/repos/ogham/dog/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
                if [ -n "$DOG_VERSION" ]; then
                    wget -q "https://github.com/ogham/dog/releases/download/${DOG_VERSION}/dog-${DOG_VERSION}-x86_64-unknown-linux-gnu.zip" -O /tmp/dog.zip
                    unzip -q /tmp/dog.zip -d /tmp
                    sudo mv /tmp/bin/dog /usr/local/bin/
                    rm -rf /tmp/dog.zip /tmp/bin
                fi
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm dog
                ;;
        esac
    fi
}

install_archive_tools() {
    log_info "Installing archive tools..."
    
    # ouch (all-in-one compression/decompression)
    if ! command -v ouch &>/dev/null; then
        log_info "Installing ouch..."
        case "$OS" in
            macos)
                brew install ouch
                ;;
            *)
                cargo install ouch 2>/dev/null || log_warn "ouch requires Rust/cargo"
                ;;
        esac
    fi
    
    # Standard archive tools
    case "$OS" in
        macos)
            brew install xz p7zip unrar
            ;;
        ubuntu|debian)
            sudo apt-get install -y xz-utils p7zip-full unrar
            ;;
        fedora|rhel|centos)
            sudo dnf install -y xz p7zip unrar
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm xz p7zip unrar
            ;;
    esac
}

install_misc_essentials() {
    log_info "Installing miscellaneous essentials..."
    
    # zoxide (smarter cd command)
    if ! command -v zoxide &>/dev/null; then
        log_info "Installing zoxide..."
        case "$OS" in
            macos)
                brew install zoxide
                ;;
            ubuntu|debian)
                sudo apt-get install -y zoxide || {
                    cargo install zoxide 2>/dev/null || log_warn "zoxide requires Rust/cargo"
                }
                ;;
            fedora|rhel|centos)
                sudo dnf install -y zoxide
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm zoxide
                ;;
        esac
    fi
    
    # hyperfine (command benchmarking)
    if ! command -v hyperfine &>/dev/null; then
        log_info "Installing hyperfine..."
        case "$OS" in
            macos)
                brew install hyperfine
                ;;
            ubuntu|debian)
                sudo apt-get install -y hyperfine || {
                    cargo install hyperfine 2>/dev/null || log_warn "hyperfine requires Rust/cargo"
                }
                ;;
            fedora|rhel|centos)
                sudo dnf install -y hyperfine
                ;;
            arch|manjaro)
                sudo pacman -S --noconfirm hyperfine
                ;;
        esac
    fi
    
    # tokei (code statistics)
    if ! command -v tokei &>/dev/null; then
        log_info "Installing tokei..."
        case "$OS" in
            macos)
                brew install tokei
                ;;
            *)
                cargo install tokei 2>/dev/null || log_warn "tokei requires Rust/cargo"
                ;;
        esac
    fi
    
    # tealdeer (tldr rust implementation)
    if ! command -v tldr &>/dev/null; then
        log_info "Installing tealdeer (tldr)..."
        case "$OS" in
            macos)
                brew install tealdeer
                ;;
            *)
                cargo install tealdeer 2>/dev/null || log_warn "tealdeer requires Rust/cargo"
                ;;
        esac
    fi
    
    # mcfly (smart command history search)
    if ! command -v mcfly &>/dev/null; then
        log_info "Installing mcfly..."
        case "$OS" in
            macos)
                brew install mcfly
                ;;
            *)
                cargo install mcfly 2>/dev/null || log_warn "mcfly requires Rust/cargo"
                ;;
        esac
    fi
    
    # atuin (magical shell history)
    if ! command -v atuin &>/dev/null; then
        log_info "Installing atuin..."
        case "$OS" in
            macos)
                brew install atuin
                ;;
            *)
                cargo install atuin 2>/dev/null || log_warn "atuin requires Rust/cargo"
                ;;
        esac
    fi
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # Define logging functions if not already defined
    if ! command -v log_info &>/dev/null; then
        RED='\033[0;31m'
        GREEN='\033[0;32m'
        YELLOW='\033[1;33m'
        BLUE='\033[0;34m'
        NC='\033[0m'
        
        log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
        log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
        log_warn() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
        log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
    fi
    
    # Detect OS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    elif [[ -f /etc/os-release ]]; then
        . /etc/os-release
        case "$ID" in
            ubuntu|debian|pop) OS="ubuntu" ;;
            fedora|rhel|centos|rocky|alma) OS="fedora" ;;
            arch|manjaro|endeavouros) OS="arch" ;;
            *) OS="linux" ;;
        esac
    else
        OS="linux"
    fi
    
    install_community_favorites
fi
