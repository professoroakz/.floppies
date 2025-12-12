# Dotfiles Guide

Comprehensive guide to all dotfiles and configurations included in .floppies.

## Overview

.floppies includes extensive dotfiles and configurations inspired by awesome-dotfiles collections, optimized for modern development workflows across all platforms.

## Included Dotfiles

### Shell Configuration

#### `.bashrc` / `.bash_profile`
- Custom prompt with git branch info
- History configuration (unlimited, de-duplication)
- Shell options (globstar, checkwinsize, etc.)
- Load custom aliases and functions
- Integration with base16-shell for random colors
- PATH management for all package managers

#### `.zshrc`
- Oh My Zsh integration
- Custom plugins (git, docker, kubectl, etc.)
- Starship prompt or powerlevel10k
- Syntax highlighting and autosuggestions
- History configuration
- Aliases and functions

#### `.bash_aliases`
- Navigation shortcuts
- Git shortcuts (gaa, gcm, gph, gpl, etc.)
- Docker shortcuts (dps, di, dex, dcu, etc.)
- Kubernetes shortcuts (k, kgp, kgs, etc.)
- Development shortcuts (serve, npmr, pya, etc.)
- System utilities (update, ports, myip, weather)
- Useful functions (mkcd, extract)

### Editor Configuration

#### `.vimrc`
- vim-plug plugin manager
- Sensible defaults (line numbers, syntax highlighting)
- Custom keybindings
- Language-specific settings
- Plugin configurations

#### `.editorconfig`
- Consistent coding styles across editors
- Language-specific indentation
- Line ending and charset settings
- Works with VSCode, Vim, IntelliJ, Sublime, etc.

### Terminal Configuration

#### `.tmux.conf`
- Mouse support
- Vi-mode keybindings
- Custom status bar
- Pane navigation shortcuts
- Copy-paste improvements
- Plugin manager (tpm)

#### `.screenrc`
- 256 color support
- Custom status bar
- Mouse scrolling
- Increased scrollback
- Useful keybindings

#### `.inputrc` (Readline)
- Case-insensitive tab completion
- Colored file type indicators
- Smart history search with arrow keys
- Word navigation with Ctrl/Alt arrows
- Better completion behavior

### Git Configuration

#### `.gitconfig`
- User info (name, email)
- Useful aliases (co, br, st, unstage, etc.)
- Color output
- Default branch name
- Pull rebase by default
- Credential caching

### Tool Configuration

#### `.curlrc`
- Follow redirects
- Show errors
- Resume downloads
- Reasonable timeouts
- User agent string

#### `.wgetrc`
- Timestamping
- Retry on failure
- Trust server names
- Show progress bar
- Continue partial downloads

## Shell Enhancements

### thefuck
Command corrector that suggests fixes for mistyped commands.

```bash
$ apt-get install vim
E: Could not open lock file...

$ fuck
sudo apt-get install vim [enter/↑/↓/ctrl+c]
```

### autojump / z
Smart directory navigation based on frequency and recency.

```bash
$ j project  # jumps to most-used directory matching "project"
$ z doc      # similar to autojump
```

### direnv
Load and unload environment variables based on directory.

```bash
# In project/.envrc
export DATABASE_URL=postgres://localhost/mydb

$ cd project
direnv: loading .envrc
direnv: export +DATABASE_URL
```

### fzf
Fuzzy finder for command line.

```bash
$ vim **<TAB>     # fuzzy file search
$ kill -9 **<TAB> # fuzzy process search
$ ssh **<TAB>     # fuzzy host search
$ Ctrl-R          # fuzzy history search
```

## Font Configuration

### Installed Fonts

- **Fira Code** - Popular with ligatures
- **JetBrains Mono** - Excellent for coding
- **Cascadia Code** - Microsoft's modern font
- **Hack** - Clean and readable
- **Source Code Pro** - Adobe's programming font
- **Meslo** - Customized for Powerline
- **Nerd Fonts** - All fonts patched with icons

### Using Fonts

**iTerm2:**
1. Preferences → Profiles → Text
2. Change Font to "FiraCode Nerd Font" or similar
3. Enable ligatures if desired

**VSCode:**
```json
{
  "editor.fontFamily": "'JetBrains Mono', 'Fira Code', monospace",
  "editor.fontLigatures": true,
  "terminal.integrated.fontFamily": "'MesloLGS NF'"
}
```

**Terminal (Linux):**
Edit → Preferences → Profile → Text → Custom font

## Color Schemes

### base16-shell
256+ color themes that work across all terminal emulators.

```bash
# List available themes
base16

# Apply theme
base16_oceanicnext

# Random theme on shell start (already configured)
# Themes change every time you open a new terminal
```

### Popular Themes
- **base16-oceanicnext** - Modern, balanced
- **base16-tomorrow-night** - Classic dark
- **base16-solarized-dark** - Popular, easy on eyes
- **base16-monokai** - Vibrant, Sublime-inspired
- **base16-nord** - Arctic-inspired
- **base16-gruvbox-dark** - Retro groove
- **base16-dracula** - Dark purple theme

## Advanced Configurations

### SSH Config (`~/.ssh/config`)

```ssh
# Default settings
Host *
  ServerAliveInterval 60
  ServerAliveCountMax 3
  Compression yes
  
# Specific hosts
Host github
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa_github

Host prod
  HostName production.example.com
  User deploy
  IdentityFile ~/.ssh/id_rsa_prod
  ForwardAgent yes
```

### Environment Variables

Add to `.bashrc` or `.zshrc`:

```bash
# Preferred editor
export EDITOR=vim
export VISUAL=code

# Language settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Development paths
export PROJECTS_DIR=~/work
export GOPATH=~/go
export PATH="$GOPATH/bin:$PATH"

# Tool-specific settings
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export HOMEBREW_NO_ANALYTICS=1
export DOCKER_SCAN_SUGGEST=false
```

### Custom Functions

Add to `.bash_aliases`:

```bash
# Create and enter directory
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Extract any archive
extract() {
  # See bash_aliases.example for full implementation
}

# Git clone and enter
gcl() {
  git clone "$1" && cd "$(basename "$1" .git)"
}

# Quick backup
backup() {
  cp "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
}

# Find and replace in files
findreplace() {
  find . -type f -exec sed -i "s/$1/$2/g" {} +
}
```

## Customization

### Adding Your Own Aliases

Edit `~/.bash_aliases` or `~/.zshrc`:

```bash
# Project shortcuts
alias myproject='cd ~/work/my-awesome-project'
alias logs='tail -f /var/log/myapp.log'

# Custom commands
alias python=python3
alias pip=pip3

# Clipboard helpers (macOS)
alias pbcopy='pbcopy'
alias pbpaste='pbpaste'

# Clipboard helpers (Linux)
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
```

### Per-Project Settings with direnv

Create `.envrc` in project directory:

```bash
# Load .env file
dotenv

# Add local bin to PATH
PATH_add bin

# Set project-specific environment
export DATABASE_URL=postgres://localhost/myproject
export RAILS_ENV=development
export NODE_ENV=development
```

## Synchronization

### Syncing Dotfiles Across Machines

```bash
# Backup current dotfiles
cd ~
tar czf dotfiles-backup-$(date +%Y%m%d).tar.gz \
  .bashrc .bash_profile .zshrc .vimrc .tmux.conf .gitconfig

# Copy to new machine
scp dotfiles-backup-*.tar.gz user@newmachine:~

# Or use git
cd ~
git init
git add .bashrc .zshrc .vimrc .tmux.conf .gitconfig
git commit -m "Initial dotfiles"
git remote add origin git@github.com:yourusername/dotfiles.git
git push -u origin main
```

### Using Syncthing

Already installed! Configure syncing of dotfiles folder:
- Set up on multiple machines
- Select `~/dotfiles` or specific config files
- Automatic bi-directional sync

## Resources

- [awesome-dotfiles](https://github.com/webpro/awesome-dotfiles)
- [dotfiles.github.io](https://dotfiles.github.io/)
- [Mathias Bynens' dotfiles](https://github.com/mathiasbynens/dotfiles)
- [Awesome Shell](https://github.com/alebcay/awesome-shell)
- [Nerd Fonts](https://www.nerdfonts.com/)

## Troubleshooting

### Colors Not Working

```bash
# Check TERM variable
echo $TERM  # should be xterm-256color or screen-256color

# Set it if needed
export TERM=xterm-256color

# For tmux
tmux -2  # force 256 colors
```

### Fonts Not Showing Icons

- Ensure you're using a Nerd Font variant
- Check terminal font settings
- May need to restart terminal application

### Slow Shell Startup

```bash
# Profile shell startup
time zsh -i -c exit
time bash --login -c exit

# Common culprits:
# - Too many Oh My Zsh plugins
# - Slow NFS/network home directory
# - Resource-intensive prompt themes
```

## Next Steps

1. Review and customize `~/.bash_aliases`
2. Try different color schemes with `base16_<theme>`
3. Learn fzf keybindings (Ctrl-R for history, Alt-C for cd)
4. Set up direnv for project-specific environments
5. Explore tmux plugin manager (tpm) plugins
6. Configure your SSH settings in `~/.ssh/config`
7. Set up git aliases you use most often
