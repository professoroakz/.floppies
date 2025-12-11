#!/usr/bin/env bash

#############################################
# Dotfiles Configuration
#############################################

configure_dotfiles() {
    log_info "Configuring dotfiles..."
    
    DOTFILES_DIR="$SCRIPT_DIR/dotfiles"
    
    # Backup existing dotfiles
    backup_dotfiles
    
    # Configure shell
    configure_shell
    
    # Configure Git
    configure_git
    
    # Configure Vim
    configure_vim
    
    # Configure tmux
    configure_tmux
    
    # Configure VSCode
    configure_vscode_settings
    
    log_success "Dotfiles configured!"
}

backup_dotfiles() {
    log_info "Backing up existing dotfiles..."
    
    BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    
    local files=(".bashrc" ".bash_profile" ".zshrc" ".vimrc" ".tmux.conf" ".gitconfig")
    
    for file in "${files[@]}"; do
        if [ -f "$HOME/$file" ]; then
            cp "$HOME/$file" "$BACKUP_DIR/"
            log_info "Backed up $file"
        fi
    done
    
    log_info "Backup created at: $BACKUP_DIR"
}

configure_shell() {
    log_info "Configuring shell..."
    
    # Create .bashrc
    cat > "$HOME/.bashrc" << 'EOF'
# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History settings
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend

# Check window size after each command
shopt -s checkwinsize

# Enable color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph'

# Modern CLI tools
if command -v bat &> /dev/null; then
    alias cat='bat'
fi
if command -v exa &> /dev/null; then
    alias ls='exa'
    alias ll='exa -la'
fi

# Load additional configs
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.bash_functions ] && . ~/.bash_functions

# Starship prompt
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Language-specific paths
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv &> /dev/null; then
    eval "$(pyenv init -)"
fi
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
EOF
    
    # Create .bash_profile
    cat > "$HOME/.bash_profile" << 'EOF'
# .bash_profile

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
EOF
    
    # Create .zshrc for zsh users
    cat > "$HOME/.zshrc" << 'EOF'
# .zshrc

# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Plugins
plugins=(
    git
    docker
    kubectl
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
)

# Load Oh My Zsh
if [ -d "$ZSH" ]; then
    source $ZSH/oh-my-zsh.sh
fi

# Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph'

# Modern CLI tools
if command -v bat &> /dev/null; then
    alias cat='bat'
fi
if command -v exa &> /dev/null; then
    alias ls='exa'
    alias ll='exa -la'
fi

# Starship prompt (overrides Oh My Zsh theme)
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Language-specific paths
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv &> /dev/null; then
    eval "$(pyenv init -)"
fi
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
EOF
    
    log_success "Shell configuration complete!"
}

configure_git() {
    log_info "Configuring Git..."
    
    # Only set defaults if not already configured
    if [ -z "$(git config --global user.name)" ]; then
        echo -n "Enter your Git username: "
        read -r git_name
        git config --global user.name "$git_name"
    fi
    
    if [ -z "$(git config --global user.email)" ]; then
        echo -n "Enter your Git email: "
        read -r git_email
        git config --global user.email "$git_email"
    fi
    
    # Set useful Git aliases
    git config --global alias.st status
    git config --global alias.co checkout
    git config --global alias.br branch
    git config --global alias.ci commit
    git config --global alias.unstage 'reset HEAD --'
    git config --global alias.last 'log -1 HEAD'
    git config --global alias.lg "log --oneline --graph --all --decorate"
    
    # Set default branch name
    git config --global init.defaultBranch main
    
    # Enable color
    git config --global color.ui auto
    
    # Set pull strategy
    git config --global pull.rebase false
    
    log_success "Git configuration complete!"
}

configure_vim() {
    log_info "Configuring Vim..."
    
    cat > "$HOME/.vimrc" << 'EOF'
" .vimrc

" Enable syntax highlighting
syntax on

" Enable line numbers
set number
set relativenumber

" Enable mouse support
set mouse=a

" Indentation
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

" Search settings
set hlsearch
set incsearch
set ignorecase
set smartcase

" Display settings
set showcmd
set showmatch
set ruler
set laststatus=2

" Enable file type detection
filetype plugin indent on

" Color scheme
colorscheme desert

" Plugins (if vim-plug is installed)
if filereadable(expand("~/.vim/autoload/plug.vim"))
    call plug#begin('~/.vim/plugged')
    
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-fugitive'
    Plug 'preservim/nerdtree'
    Plug 'vim-airline/vim-airline'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    
    call plug#end()
    
    " NERDTree
    map <C-n> :NERDTreeToggle<CR>
endif
EOF
    
    log_success "Vim configuration complete!"
}

configure_tmux() {
    log_info "Configuring tmux..."
    
    cat > "$HOME/.tmux.conf" << 'EOF'
# .tmux.conf

# Set prefix to Ctrl-a
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# Split panes using | and -
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# Reload config
bind r source-file ~/.tmux.conf \; display "Config reloaded!"

# Enable mouse mode
set -g mouse on

# Don't rename windows automatically
set-option -g allow-rename off

# Start windows and panes at 1, not 0
set -g base-index 1
setw -g pane-base-index 1

# Status bar
set -g status-bg black
set -g status-fg white
set -g status-interval 60
set -g status-left-length 30
set -g status-left '#[fg=green](#S) #(whoami) '
set -g status-right '#[fg=yellow]#(cut -d " " -f 1-3 /proc/loadavg)#[default] #[fg=white]%H:%M#[default]'

# Plugins (if TPM is installed)
if "test -d ~/.tmux/plugins/tpm" \
    "set -g @plugin 'tmux-plugins/tpm'; \
     set -g @plugin 'tmux-plugins/tmux-sensible'; \
     set -g @plugin 'tmux-plugins/tmux-resurrect'; \
     run '~/.tmux/plugins/tpm/tpm'"
EOF
    
    log_success "tmux configuration complete!"
}

configure_vscode_settings() {
    log_info "Configuring VSCode settings..."
    
    local vscode_dir=""
    case "$OS" in
        macos)
            vscode_dir="$HOME/Library/Application Support/Code/User"
            ;;
        linux|ubuntu|debian|fedora|rhel|centos|arch|manjaro)
            vscode_dir="$HOME/.config/Code/User"
            ;;
        windows)
            if grep -qi microsoft /proc/version 2>/dev/null; then
                # WSL - settings are on Windows side
                log_info "For WSL, configure VSCode on Windows host"
                return
            fi
            vscode_dir="$HOME/AppData/Roaming/Code/User"
            ;;
    esac
    
    if [ -n "$vscode_dir" ]; then
        mkdir -p "$vscode_dir"
        
        cat > "$vscode_dir/settings.json" << 'EOF'
{
    "editor.fontSize": 14,
    "editor.tabSize": 2,
    "editor.insertSpaces": true,
    "editor.formatOnSave": true,
    "editor.minimap.enabled": true,
    "editor.rulers": [80, 120],
    "files.autoSave": "afterDelay",
    "files.trimTrailingWhitespace": true,
    "workbench.colorTheme": "Default Dark+",
    "terminal.integrated.fontSize": 12,
    "git.autofetch": true,
    "git.confirmSync": false,
    "explorer.confirmDelete": false,
    "prettier.singleQuote": true,
    "prettier.trailingComma": "es5"
}
EOF
        
        log_success "VSCode settings configured!"
    fi
}
