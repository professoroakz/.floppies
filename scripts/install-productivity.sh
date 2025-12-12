#!/usr/bin/env bash

#############################################
# Productivity Tools Installation
#############################################
# Includes: AI CLIs, note-taking, todo management,
# communication tools, password managers, image viewers,
# self-hosting tools, and productivity apps
#############################################

install_productivity_tools() {
    log_info "Installing productivity tools..."
    
    install_ai_cli_tools
    install_note_taking_tools
    install_todo_management
    install_communication_tools
    install_password_managers
    install_image_viewers
    install_self_hosting_tools
    install_productivity_apps
    
    log_success "Productivity tools installed!"
}

#############################################
# AI CLI Tools
#############################################

install_ai_cli_tools() {
    log_info "Installing AI CLI tools..."
    
    case "$OS" in
        macos)
            # GitHub Copilot CLI
            if ! command -v github-copilot-cli &> /dev/null; then
                log_info "Installing GitHub Copilot CLI..."
                npm install -g @githubnext/github-copilot-cli
            fi
            
            # OpenAI CLI (unofficial)
            if ! command -v chatgpt &> /dev/null; then
                log_info "Installing ChatGPT CLI..."
                npm install -g chatgpt-cli
            fi
            
            # Shell-GPT
            if ! command -v sgpt &> /dev/null; then
                log_info "Installing Shell-GPT..."
                pip3 install shell-gpt
            fi
            
            # Aider (AI pair programming)
            if ! command -v aider &> /dev/null; then
                log_info "Installing Aider..."
                pip3 install aider-chat
            fi
            
            # GPT-Commit (AI commit messages)
            if ! command -v gpt-commit &> /dev/null; then
                log_info "Installing GPT-Commit..."
                npm install -g gpt-commit
            fi
            ;;
        ubuntu|debian)
            # Install Node.js tools if npm is available
            if command -v npm &> /dev/null; then
                npm install -g @githubnext/github-copilot-cli
                npm install -g chatgpt-cli
                npm install -g gpt-commit
            fi
            
            # Python tools
            if command -v pip3 &> /dev/null; then
                pip3 install --user shell-gpt aider-chat
            fi
            ;;
        fedora|rhel|centos|arch|manjaro)
            # Python tools
            if command -v pip3 &> /dev/null; then
                pip3 install --user shell-gpt aider-chat
            fi
            ;;
    esac
    
    log_success "AI CLI tools installed!"
}

#############################################
# Note-Taking Tools
#############################################

install_note_taking_tools() {
    log_info "Installing note-taking tools..."
    
    case "$OS" in
        macos)
            # Obsidian
            brew install --cask obsidian
            
            # Standard Notes
            brew install --cask standard-notes
            
            # Simplenote
            brew install --cask simplenote
            
            # Notion (if available)
            brew install --cask notion || log_warning "Notion not available via Homebrew"
            
            # Joplin - open source note taking
            brew install --cask joplin
            
            # Markdown CLIs
            brew install pandoc
            brew install glow  # Markdown viewer
            brew install mdcat # Cat for markdown
            
            # Notable - markdown-based note-taking
            brew install --cask notable || log_warning "Notable not available"
            
            # CLI note-taking tools
            npm install -g note
            pip3 install jrnl  # Command line journal
            
            # Terminal markdown editor
            brew install vimwiki || true
            ;;
        ubuntu|debian)
            # Joplin AppImage - get latest version
            if ! command -v joplin &> /dev/null; then
                log_info "Installing Joplin AppImage..."
                JOPLIN_URL=$(curl -s https://api.github.com/repos/laurent22/joplin/releases/latest | grep "browser_download_url.*AppImage" | cut -d '"' -f 4 | head -n 1)
                if [ -n "$JOPLIN_URL" ]; then
                    wget -O /tmp/Joplin.AppImage "$JOPLIN_URL" 2>/dev/null && chmod +x /tmp/Joplin.AppImage || true
                fi
            fi
            
            # Markdown tools
            sudo apt-get install -y pandoc
            
            # CLI tools
            if command -v npm &> /dev/null; then
                npm install -g note
            fi
            
            if command -v pip3 &> /dev/null; then
                pip3 install --user jrnl
            fi
            ;;
        fedora|rhel|centos)
            # Markdown tools
            if command -v dnf &> /dev/null; then
                sudo dnf install -y pandoc
            else
                sudo yum install -y pandoc
            fi
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm joplin pandoc
            ;;
    esac
    
    # Obsidian sync alternatives (self-hosted)
    log_info "Note: For self-hosted Obsidian sync, consider Syncthing or Git"
    
    log_success "Note-taking tools installed!"
}

#############################################
# Todo Management
#############################################

install_todo_management() {
    log_info "Installing todo management tools..."
    
    case "$OS" in
        macos)
            # Things (commercial, install manually from App Store)
            log_info "Things 3 available in Mac App Store"
            
            # Todoist CLI
            if ! command -v todoist &> /dev/null; then
                log_info "Installing Todoist CLI..."
                pip3 install todoist-python
            fi
            
            # todo.txt-cli
            if ! command -v todo.sh &> /dev/null; then
                log_info "Installing todo.txt-cli..."
                brew install todo-txt
            fi
            
            # Taskwarrior
            brew install task
            brew install tasksh  # Task shell
            
            # Memo - Simple memo/note CLI
            if ! command -v memo &> /dev/null; then
                log_info "Installing memo..."
                brew tap mattn/memo
                brew install memo
            fi
            
            # Doing - CLI todo manager
            if ! command -v doing &> /dev/null; then
                gem install doing
            fi
            
            # t - Twitter-like CLI todo
            gem install t
            
            # Taskbook - Tasks and notes in terminal
            npm install -g taskbook
            
            # ntodotxt - Cross-platform todo.txt with mobile sync
            if ! command -v ntodotxt &> /dev/null; then
                log_info "Installing ntodotxt..."
                pip3 install ntodotxt
            fi
            ;;
        ubuntu|debian)
            # todo.txt-cli
            if ! command -v todo.sh &> /dev/null; then
                log_info "Installing todo.txt-cli..."
                sudo apt-get install -y todotxt-cli
            fi
            
            # ntodotxt
            if command -v pip3 &> /dev/null; then
                pip3 install --user ntodotxt
            fi
            
            # Taskwarrior
            sudo apt-get install -y task
            
            # Python/npm tools
            if command -v pip3 &> /dev/null; then
                pip3 install --user todoist-python
            fi
            
            if command -v npm &> /dev/null; then
                npm install -g taskbook
            fi
            ;;
        fedora|rhel|centos)
            if command -v dnf &> /dev/null; then
                sudo dnf install -y task
            else
                sudo yum install -y task
            fi
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm task
            sudo pacman -S --noconfirm todotxt
            ;;
    esac
    
    # Create todo.txt config if doesn't exist
    if [ ! -f "$HOME/.todo/config" ]; then
        mkdir -p "$HOME/.todo"
        cat > "$HOME/.todo/config" << 'EOF'
export TODO_DIR="$HOME/.todo"
export TODO_FILE="$TODO_DIR/todo.txt"
export DONE_FILE="$TODO_DIR/done.txt"
export REPORT_FILE="$TODO_DIR/report.txt"
EOF
    fi
    
    # Setup GitHub sync for todo.txt (optional)
    log_info "Setting up todo.txt GitHub sync..."
    cat > "$HOME/.todo/sync-setup.sh" << 'EOF'
#!/usr/bin/env bash
# Todo.txt GitHub Sync Setup Script
# This script helps you set up automatic syncing of todo.txt via GitHub

echo "📝 Todo.txt GitHub Sync Setup"
echo "================================"
echo ""
echo "This will create a private GitHub repository to sync your todo.txt files"
echo "across devices (including Android via Termux with termux-tasker)."
echo ""
read -p "Do you want to set up GitHub sync? (y/n) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd "$HOME/.todo" || exit 1
    
    # Initialize git if not already initialized
    if [ ! -d ".git" ]; then
        git init
        echo "todo.txt" > .gitignore
        echo "done.txt" >> .gitignore
        echo "report.txt" >> .gitignore
        git add .gitignore config
        git commit -m "Initial commit: todo.txt setup"
    fi
    
    echo ""
    echo "Next steps:"
    echo "1. Create a private GitHub repository (e.g., 'todo-sync')"
    echo "2. Run: git remote add origin git@github.com:YOUR_USERNAME/todo-sync.git"
    echo "3. Run: git push -u origin main"
    echo ""
    echo "For Android sync with Termux:"
    echo "1. Install Termux and Termux:Tasker from F-Droid"
    echo "2. In Termux: pkg install git openssh"
    echo "3. Setup SSH keys: ssh-keygen && cat ~/.ssh/id_rsa.pub"
    echo "4. Add the key to your GitHub account"
    echo "5. Clone the repo: git clone git@github.com:YOUR_USERNAME/todo-sync.git ~/.todo"
    echo "6. Create Termux:Tasker script for auto-sync"
    echo ""
    echo "Sample Termux sync script (~/.termux/tasker/todo-sync.sh):"
    echo "#!/data/data/com.termux/files/usr/bin/bash"
    echo "cd ~/.todo && git pull && git add -A && git commit -m \"Auto-sync \$(date)\" && git push"
fi
EOF
    chmod +x "$HOME/.todo/sync-setup.sh"
    
    log_info "Run ~/.todo/sync-setup.sh to configure GitHub sync for todo.txt"
    log_success "Todo management tools installed!"
}

#############################################
# Communication Tools
#############################################

install_communication_tools() {
    log_info "Installing communication tools..."
    
    case "$OS" in
        macos)
            # Slack
            brew install --cask slack
            
            # Telegram
            brew install --cask telegram
            
            # Signal
            brew install --cask signal
            
            # Discord
            brew install --cask discord
            
            # Zoom
            brew install --cask zoom
            
            # Microsoft Teams
            brew install --cask microsoft-teams
            
            # WhatsApp
            brew install --cask whatsapp
            
            # Element (Matrix client)
            brew install --cask element
            
            # Slack CLI
            if ! command -v slack &> /dev/null; then
                log_info "Install Slack CLI from: https://api.slack.com/automation/cli/install"
            fi
            ;;
        ubuntu|debian)
            # Telegram
            sudo snap install telegram-desktop 2>/dev/null || log_warning "Install Telegram manually"
            
            # Signal
            wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > /tmp/signal-desktop-keyring.gpg
            sudo mv /tmp/signal-desktop-keyring.gpg /usr/share/keyrings/
            echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | sudo tee /etc/apt/sources.list.d/signal-xenial.list
            sudo apt-get update
            sudo apt-get install -y signal-desktop
            
            # Slack
            sudo snap install slack 2>/dev/null || log_warning "Install Slack manually"
            
            # Discord
            sudo snap install discord 2>/dev/null || log_warning "Install Discord manually"
            ;;
        fedora|rhel|centos)
            log_info "Install communication apps via Flatpak or from websites"
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm telegram-desktop
            sudo pacman -S --noconfirm signal-desktop
            ;;
    esac
    
    log_success "Communication tools installed!"
}

#############################################
# Password Managers
#############################################

install_password_managers() {
    log_info "Installing password managers..."
    
    case "$OS" in
        macos)
            # Bitwarden
            brew install --cask bitwarden
            
            # Bitwarden CLI
            brew install bitwarden-cli
            
            # 1Password
            brew install --cask 1password
            brew install --cask 1password-cli
            
            # KeePassXC (FOSS)
            brew install --cask keepassxc
            
            # pass (Unix password manager)
            brew install pass
            brew install pass-otp  # OTP support
            
            # gopass (team password manager)
            brew install gopass
            ;;
        ubuntu|debian)
            # Bitwarden CLI
            npm install -g @bitwarden/cli
            
            # KeePassXC
            sudo apt-get install -y keepassxc
            
            # pass
            sudo apt-get install -y pass
            
            # gopass - get latest version
            if ! command -v gopass &> /dev/null; then
                log_info "Installing gopass..."
                GOPASS_URL=$(curl -s https://api.github.com/repos/gopasspw/gopass/releases/latest | grep "browser_download_url.*_linux_amd64.deb" | cut -d '"' -f 4)
                if [ -n "$GOPASS_URL" ]; then
                    wget -O /tmp/gopass.deb "$GOPASS_URL" 2>/dev/null && sudo dpkg -i /tmp/gopass.deb 2>/dev/null || true
                fi
            fi
            ;;
        fedora|rhel|centos)
            if command -v dnf &> /dev/null; then
                sudo dnf install -y keepassxc pass
            else
                sudo yum install -y keepassxc pass
            fi
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm bitwarden keepassxc pass gopass
            ;;
    esac
    
    log_success "Password managers installed!"
}

#############################################
# Image Viewers for Terminal
#############################################

install_image_viewers() {
    log_info "Installing terminal image viewers..."
    
    case "$OS" in
        macos)
            # imgcat (iTerm2 image support)
            if [ ! -f /usr/local/bin/imgcat ]; then
                curl -o /usr/local/bin/imgcat https://iterm2.com/utilities/imgcat
                chmod +x /usr/local/bin/imgcat
            fi
            
            # viu - Image viewer
            brew install viu
            
            # timg - Terminal image and video viewer
            brew install timg
            
            # catimg
            brew install catimg
            
            # chafa - Image to text converter
            brew install chafa
            
            # ImageMagick (for display in X11/XQuartz)
            brew install imagemagick
            
            # libsixel for sixel graphics
            brew install libsixel
            ;;
        ubuntu|debian)
            # viu
            cargo install viu 2>/dev/null || log_warning "Install Rust to get viu"
            
            # catimg
            sudo apt-get install -y catimg
            
            # chafa
            sudo apt-get install -y chafa
            
            # ImageMagick
            sudo apt-get install -y imagemagick
            
            # libsixel
            sudo apt-get install -y libsixel-bin libsixel-dev
            ;;
        fedora|rhel|centos)
            if command -v dnf &> /dev/null; then
                sudo dnf install -y chafa ImageMagick libsixel
            else
                sudo yum install -y chafa ImageMagick libsixel
            fi
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm viu chafa imagemagick libsixel
            ;;
    esac
    
    # Terminal graphics protocols info
    log_info "Installed terminal image viewers:"
    log_info "  - imgcat (iTerm2 only)"
    log_info "  - viu (works in most terminals)"
    log_info "  - chafa (works in most terminals)"
    log_info "  - timg (works with sixel/kitty protocols)"
    log_info "  - catimg (ASCII art)"
    
    log_success "Image viewers installed!"
}

#############################################
# Self-Hosting Tools
#############################################

install_self_hosting_tools() {
    log_info "Installing self-hosting tools..."
    
    case "$OS" in
        macos|ubuntu|debian|fedora|rhel|centos|arch|manjaro)
            # Docker and Docker Compose (should already be installed)
            log_info "Docker should already be installed from containers module"
            
            # Portainer (Docker management UI)
            log_info "To install Portainer: docker run -d -p 9000:9000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer-ce"
            
            # Traefik (reverse proxy)
            log_info "Traefik can be installed via Docker"
            
            # Caddy (web server with automatic HTTPS)
            case "$OS" in
                macos)
                    brew install caddy
                    ;;
                ubuntu|debian)
                    sudo apt-get install -y debian-keyring debian-archive-keyring apt-transport-https
                    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
                    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
                    sudo apt-get update
                    sudo apt-get install -y caddy
                    ;;
                fedora|rhel|centos)
                    if command -v dnf &> /dev/null; then
                        sudo dnf install -y caddy
                    fi
                    ;;
                arch|manjaro)
                    sudo pacman -S --noconfirm caddy
                    ;;
            esac
            
            # Nginx
            case "$OS" in
                macos)
                    brew install nginx
                    ;;
                ubuntu|debian)
                    sudo apt-get install -y nginx
                    ;;
                fedora|rhel|centos)
                    if command -v dnf &> /dev/null; then
                        sudo dnf install -y nginx
                    else
                        sudo yum install -y nginx
                    fi
                    ;;
                arch|manjaro)
                    sudo pacman -S --noconfirm nginx
                    ;;
            esac
            
            # Coolify (self-hosting platform) - Docker-based
            log_info "To install Coolify: Download and verify the script first: curl -fsSL https://get.coollabs.io/coolify/install.sh -o /tmp/coolify-install.sh && bash /tmp/coolify-install.sh"
            
            # Syncthing (file sync)
            case "$OS" in
                macos)
                    brew install syncthing
                    ;;
                ubuntu|debian)
                    sudo apt-get install -y syncthing
                    ;;
                fedora|rhel|centos)
                    if command -v dnf &> /dev/null; then
                        sudo dnf install -y syncthing
                    fi
                    ;;
                arch|manjaro)
                    sudo pacman -S --noconfirm syncthing
                    ;;
            esac
            
            # Tailscale (secure network)
            case "$OS" in
                macos)
                    brew install --cask tailscale
                    ;;
                ubuntu|debian)
                    # Download and verify Tailscale install script
                    if ! command -v tailscale &> /dev/null; then
                        log_info "Installing Tailscale..."
                        curl -fsSL https://tailscale.com/install.sh -o /tmp/tailscale-install.sh
                        sudo sh /tmp/tailscale-install.sh
                    fi
                    ;;
                fedora|rhel|centos|arch|manjaro)
                    # Download and verify Tailscale install script
                    if ! command -v tailscale &> /dev/null; then
                        log_info "Installing Tailscale..."
                        curl -fsSL https://tailscale.com/install.sh -o /tmp/tailscale-install.sh
                        sudo sh /tmp/tailscale-install.sh
                    fi
                    ;;
            esac
            ;;
    esac
    
    log_info "Popular self-hosted apps (install via Docker):"
    log_info "  - Bitwarden/Vaultwarden (password manager)"
    log_info "  - Nextcloud (file sync, calendar, contacts)"
    log_info "  - Gitea (Git hosting)"
    log_info "  - Jellyfin (media server)"
    log_info "  - Home Assistant (home automation)"
    log_info "  - Miniflux (RSS reader)"
    log_info "  - Paperless-ngx (document management)"
    log_info "  - Bookstack (wiki/docs)"
    
    log_success "Self-hosting tools installed!"
}

#############################################
# Productivity Apps
#############################################

install_productivity_apps() {
    log_info "Installing productivity applications..."
    
    case "$OS" in
        macos)
            # Project management
            log_info "Trello, Monday.com, Asana available as web apps or from App Store"
            
            # Notion
            brew install --cask notion
            
            # Evernote
            brew install --cask evernote || log_warning "Evernote not available"
            
            # Bear (notes for Mac)
            log_info "Bear available in Mac App Store"
            
            # Alfred (productivity/launcher)
            brew install --cask alfred
            
            # Raycast (modern launcher)
            brew install --cask raycast
            
            # Rectangle (window management)
            brew install --cask rectangle
            
            # Magnet (window management)
            log_info "Magnet available in Mac App Store"
            
            # Time tracking
            brew install --cask toggl-track || log_warning "Toggl not available"
            
            # Screenshots and screen recording
            brew install --cask kap  # Screen recorder
            brew install --cask cleanshot || log_warning "CleanShot X not available (commercial)"
            
            # PDF tools
            brew install --cask skim  # PDF reader
            
            # Email clients
            log_info "Mail clients: Apple Mail (built-in), Thunderbird, Spark, Airmail"
            brew install --cask thunderbird
            
            # Calendar
            brew install --cask fantastical || log_warning "Fantastical not available (commercial)"
            
            # Focus/Pomodoro
            brew install --cask flow || log_warning "Flow not available"
            ;;
        ubuntu|debian)
            # Thunderbird
            sudo apt-get install -y thunderbird
            
            # Time tracking
            sudo snap install toggl 2>/dev/null || log_warning "Install Toggl manually"
            ;;
    esac
    
    # CLI productivity tools
    if command -v npm &> /dev/null; then
        # Zeit (time tracking CLI)
        npm install -g zeit
        
        # Notion CLI (unofficial)
        npm install -g notion-cli
    fi
    
    log_success "Productivity apps installed!"
}

# Main execution
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    install_productivity_tools
fi
