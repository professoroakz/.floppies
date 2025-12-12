# Community Favorites Guide

This guide covers the most popular and highly-requested terminal tools from Reddit (r/commandline, r/terminal, r/unixporn), YouTube reviews, and awesome lists. These are the tools power users can't live without.

## Table of Contents

- [File Managers](#file-managers)
- [System Monitors](#system-monitors)
- [Git Tools](#git-tools)
- [Text Processing](#text-processing)
- [Network Tools](#network-tools)
- [Archive Tools](#archive-tools)
- [Essential Utilities](#essential-utilities)
- [Why These Tools](#why-these-tools)

## File Managers

### lf (List Files)
**What it is:** Terminal file manager, successor to ranger  
**Why people love it:** Blazing fast, minimal, highly customizable with shell scripts  
**Best for:** Power users who want speed and keyboard-driven navigation

```bash
# Basic usage
lf

# Preview images (with ueberzug)
lf -command "set preview true"

# Configure in ~/.config/lf/lfrc
```

**Popular workflows:**
- Navigate with hjkl (vim keys)
- Bulk file operations with shell commands
- Custom keybindings for any operation

### ranger
**What it is:** Python-based file manager with rich preview  
**Why people love it:** Best file previews (images, videos, PDFs), vim-like navigation  
**Best for:** Users who want feature-rich file management

```bash
# Launch ranger
ranger

# Preview images inline (iTerm2/Kitty)
ranger --cmd="set preview_images true"
```

**Features:**
- Image preview in terminal
- Syntax highlighting for code
- Bookmark system
- Bulk renaming

### nnn
**What it is:** Fastest terminal file manager  
**Why people love it:** Minimal CPU/memory usage, incredible speed  
**Best for:** Low-resource systems, servers, quick navigation

```bash
# Launch nnn
nnn

# With plugins
nnn -P p  # preview-tui plugin
```

### broot
**What it is:** Tree view with fuzzy search and navigation  
**Why people love it:** See entire directory structure, fuzzy search everything  
**Best for:** Finding files in large projects

```bash
# Launch broot
br

# Search and navigate
# Type to fuzzy search, enter to cd
```

## System Monitors

### btop++
**What it is:** Beautiful resource monitor (modern htop)  
**Why people love it:** Gorgeous UI, mouse support, detailed metrics  
**Best for:** Primary system monitor for all users

```bash
# Launch btop++
btop

# Features:
# - CPU/Memory/Disk/Network graphs
# - Process management
# - Beautiful themes
# - Mouse support
```

**Popular themes:**
- TTY (default)
- Dracula
- Nord
- Gruvbox

### glances
**What it is:** Cross-platform monitoring tool  
**Why people love it:** Web UI, remote monitoring, plugin system  
**Best for:** Monitoring multiple systems

```bash
# Local monitoring
glances

# Web UI
glances -w  # Access at http://localhost:61208

# Remote monitoring
glances -s  # Server mode
glances -c [server-ip]  # Client mode
```

### procs
**What it is:** Modern replacement for `ps`  
**Why people love it:** Colored output, tree view, search  
**Best for:** Finding and managing processes

```bash
# List all processes
procs

# Search for process
procs firefox

# Tree view
procs --tree

# Watch mode
procs --watch
```

### duf
**What it is:** Modern `df` replacement  
**Why people love it:** Colored output, easy to read, shows everything  
**Best for:** Quick disk usage overview

```bash
# Show all filesystems
duf

# Specific mount points
duf /home

# JSON output
duf --json
```

### dust
**What it is:** `du` + rust = dust  
**Why people love it:** Visual tree, instant results  
**Best for:** Finding what's eating disk space

```bash
# Current directory
dust

# Specific depth
dust -d 1

# Show number of files
dust -n 20
```

## Git Tools

### lazygit
**What it is:** Simple terminal UI for git commands  
**Why people love it:** No need to remember git commands, visual workflow  
**Best for:** Everyone! From beginners to experts

```bash
# Launch in git repo
lazygit

# Keyboard shortcuts:
# - ↑↓: Navigate
# - c: Commit
# - P: Push
# - p: Pull
# - space: Stage/unstage
# - a: Stage all
# - A: Amend commit
# - R: Rebase
```

**Workflows:**
- Stage hunks visually
- Interactive rebase
- Resolve merge conflicts
- Manage stashes
- View commit history

### tig
**What it is:** Text-mode interface for Git  
**Why people love it:** Lightweight, fast, keyboard-driven  
**Best for:** Browsing git history

```bash
# View commit history
tig

# View specific file history
tig path/to/file

# Blame view
tig blame path/to/file

# View status
tig status
```

### gh (GitHub CLI)
**What it is:** GitHub from the command line  
**Why people love it:** No need to open browser for PRs, issues  
**Best for:** GitHub power users

```bash
# Create PR
gh pr create

# View PRs
gh pr list
gh pr view 123

# Create issue
gh issue create

# View workflow runs
gh run list
gh run view

# Clone repos
gh repo clone owner/repo
```

### git-delta
**What it is:** Syntax-highlighting pager for git  
**Why people love it:** Beautiful diffs, better than default git diff  
**Best for:** Everyone who views diffs

```bash
# Automatically used when configured in ~/.gitconfig:
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true
    light = false
    side-by-side = true
```

**Features:**
- Syntax highlighting
- Side-by-side diffs
- Line numbers
- File path display
- Git blame integration

## Text Processing

### sd (Search and Displace)
**What it is:** Modern sed replacement  
**Why people love it:** Simpler syntax, sane defaults  
**Best for:** Text replacements without regex headaches

```bash
# Replace in-place
sd 'oldtext' 'newtext' file.txt

# Preview changes
sd 'oldtext' 'newtext' file.txt --preview

# Regex with capture groups
sd '(\w+) (\w+)' '$2 $1' file.txt
```

### choose
**What it is:** Human-friendly cut/awk alternative  
**Why people love it:** Intuitive column selection  
**Best for:** Extracting columns from text

```bash
# Get first column (0-indexed)
echo "one two three" | choose 0

# Get multiple columns
echo "one two three" | choose 0 2

# Get last column
echo "one two three" | choose -1

# Split by custom delimiter
echo "one:two:three" | choose -f ':' 1
```

### difftastic
**What it is:** Semantic diff tool  
**Why people love it:** Understands code structure, not just lines  
**Best for:** Code reviews

```bash
# Diff two files
difft file1.rs file2.rs

# Use with git
git difftool --tool=difftastic

# Configure in ~/.gitconfig:
[diff]
    tool = difftastic
[difftool]
    prompt = false
[difftool "difftastic"]
    cmd = difft "$LOCAL" "$REMOTE"
```

### eza (formerly exa)
**What it is:** Modern `ls` replacement  
**Why people love it:** Colors, icons, git integration  
**Best for:** Daily file listing

```bash
# List with icons
eza --icons

# Tree view
eza --tree

# Git status
eza --long --git

# Show all metadata
eza --long --header --git

# Aliases (add to .bashrc):
alias ls='eza --icons'
alias ll='eza --long --header --git --icons'
alias la='eza --long --all --header --git --icons'
alias lt='eza --tree --icons'
```

## Network Tools

### gping
**What it is:** Ping with a graph  
**Why people love it:** Visual ping, see patterns  
**Best for:** Network troubleshooting

```bash
# Ping a host
gping google.com

# Ping multiple hosts
gping google.com cloudflare.com

# With colors
gping --color google.com
```

### bandwhich
**What it is:** Network bandwidth monitor by process  
**Why people love it:** See which process uses bandwidth  
**Best for:** Finding bandwidth hogs

```bash
# Launch bandwhich (requires sudo)
sudo bandwhich

# Features:
# - Bandwidth by process
# - Network connections
# - Remote addresses
# - Real-time updates
```

### dog
**What it is:** Modern `dig` replacement  
**Why people love it:** Colored output, clear format  
**Best for:** DNS lookups

```bash
# Basic query
dog example.com

# Specific record type
dog example.com MX

# Query specific nameserver
dog example.com @8.8.8.8

# JSON output
dog example.com --json
```

## Archive Tools

### ouch
**What it is:** All-in-one compression/decompression tool  
**Why people love it:** One command for all formats, smart detection  
**Best for:** Everyone dealing with archives

```bash
# Compress
ouch compress file.txt file.txt.gz
ouch compress dir/ archive.tar.gz
ouch compress dir/ archive.zip

# Decompress (auto-detects format)
ouch decompress archive.tar.gz
ouch decompress archive.zip

# List contents
ouch list archive.tar.gz

# Supported formats:
# .tar, .zip, .gz, .xz, .bz2, .7z, .rar
```

## Essential Utilities

### zoxide
**What it is:** Smarter cd command (z, autojump successor)  
**Why people love it:** Jump to directories by frecency  
**Best for:** Everyone! Never type full paths again

```bash
# After installation, use 'z' instead of 'cd'
z documents
z proj  # jumps to ~/projects or ~/work/project
z ..    # parent directory

# Interactive selection
zi doc  # shows menu of matching dirs

# Remove directory from database
zoxide remove /path/to/dir

# Query database
zoxide query doc
```

**Setup in .bashrc/.zshrc:**
```bash
eval "$(zoxide init bash)"  # for bash
eval "$(zoxide init zsh)"   # for zsh
```

### hyperfine
**What it is:** Command-line benchmarking tool  
**Why people love it:** Accurate, statistical, warm-up runs  
**Best for:** Comparing command performance

```bash
# Benchmark a command
hyperfine 'sleep 0.3'

# Compare commands
hyperfine 'grep pattern file.txt' 'rg pattern file.txt'

# With warm-up runs
hyperfine --warmup 3 'command'

# Export results
hyperfine --export-json results.json 'command'
```

### tokei
**What it is:** Code statistics tool  
**Why people love it:** Fast, accurate, beautiful output  
**Best for:** Project statistics

```bash
# Count lines in current directory
tokei

# Specific directory
tokei ~/projects/myapp

# Sort by lines of code
tokei --sort code

# Output JSON
tokei --output json
```

### mcfly
**What it is:** Smart command history search  
**Why people love it:** Context-aware, neural network powered  
**Best for:** Never losing that command you ran last week

```bash
# After installation, Ctrl+R to search
# Features:
# - Learns from your patterns
# - Considers current directory
# - Prioritizes recent commands
# - Fast fuzzy search
```

**Setup in .bashrc/.zshrc:**
```bash
eval "$(mcfly init bash)"  # for bash
eval "$(mcfly init zsh)"   # for zsh
```

### atuin
**What it is:** Magical shell history  
**Why people love it:** Sync history across machines, searchable  
**Best for:** Multi-machine workflows

```bash
# After installation, Ctrl+R to search
atuin search

# Sync history
atuin sync

# Import existing history
atuin import auto

# Statistics
atuin stats
```

**Features:**
- Encrypted sync across machines
- Full-text search
- Context tracking (directory, exit code, duration)
- Statistics and insights
- SQLite database

**Setup:**
```bash
# Register (for sync)
atuin register

# Login
atuin login

# Configure in .bashrc/.zshrc
eval "$(atuin init bash)"  # for bash
eval "$(atuin init zsh)"   # for zsh
```

## Why These Tools?

### Reddit Community Insights

**From r/commandline:**
- lazygit: "Game changer for git workflow"
- btop++: "Most beautiful system monitor"
- zoxide: "Can't use cd anymore"
- eza: "ls on steroids"
- hyperfine: "Essential for optimization"

**From r/terminal:**
- lf/ranger: "Must-have for file management"
- delta: "Makes git diffs actually readable"
- atuin: "Best history search, period"
- ouch: "Why didn't this exist before?"

**From r/unixporn:**
- btop++ with Nord theme: Most popular setup
- eza with icons: Standard in dotfiles
- Starship + zoxide: Essential combo

### YouTube Recommendations

**Popular YouTubers (ThePrimeagen, Dreams of Code, typecraft):**
- lazygit: "Daily driver for git"
- tmux + btop++: "Perfect monitoring setup"
- zoxide: "First thing I install"
- atuin: "Sync history everywhere"

### Awesome Lists Analysis

**Most starred from awesome-cli:**
1. bat (already included) - 45k+ stars
2. fzf (already included) - 58k+ stars
3. ripgrep (already included) - 44k+ stars
4. **lazygit** - 42k+ stars ✅ NOW INCLUDED
5. **delta** - 20k+ stars ✅ NOW INCLUDED
6. **zoxide** - 17k+ stars ✅ NOW INCLUDED

### Performance Comparisons

**Speed tests (Reddit benchmarks):**
- lf vs ranger: lf is 3-5x faster
- eza vs exa: eza is maintained, exa is abandoned
- btop++ vs htop: btop++ more features, slight overhead
- zoxide vs autojump: zoxide 10-15x faster
- dust vs du: dust 2-3x faster with better UI

### Common Workflows

**The Modern Terminal Setup (Most Popular):**
```bash
# Daily tools
eza (ls replacement)
bat (cat replacement)
zoxide (cd replacement)
delta (git diff)
lazygit (git UI)
btop++ (system monitor)
atuin (history search)

# File management
lf or ranger (file browser)
ouch (archives)
dust (disk usage)

# Development
tokei (code stats)
hyperfine (benchmarks)
gh (GitHub CLI)
```

**The Minimalist Setup:**
```bash
# Essential only
eza
bat
zoxide
lazygit
btop++
```

**The Power User Setup:**
```bash
# Everything
All of the above +
mcfly (smart history)
bandwhich (network monitor)
procs (process viewer)
gping (network diagnostics)
difftastic (semantic diff)
```

## Installation

All these tools are installed via:

```bash
./install.sh
# Select option 3 (Custom Installation)
# Select option 12 (Community Favorites)
```

Or install everything with:
```bash
./install.sh
# Select option 1 (Full Installation)
```

## Configuration Examples

### Recommended Aliases

Add to `.bashrc` or `.zshrc`:

```bash
# Modern replacements
alias ls='eza --icons'
alias ll='eza --long --header --git --icons'
alias la='eza --long --all --header --git --icons'
alias lt='eza --tree --level=2 --icons'
alias cat='bat'
alias cd='z'

# Quick access
alias lg='lazygit'
alias top='btop'
alias du='dust'
alias df='duf'
alias ping='gping'
alias dig='dog'

# Git with enhancements
alias gd='git diff | delta'
alias gl='git log --graph --oneline | delta'
```

### Shell Integration

Add to `.bashrc`:
```bash
# zoxide (must be last)
eval "$(zoxide init bash)"

# atuin (optional, for sync)
eval "$(atuin init bash)"

# mcfly (optional, alternative to atuin)
eval "$(mcfly init bash)"

# direnv (if using per-directory env)
eval "$(direnv hook bash)"
```

Add to `.zshrc`:
```bash
# zoxide (must be last)
eval "$(zoxide init zsh)"

# atuin (optional)
eval "$(atuin init zsh)"

# mcfly (optional)
eval "$(mcfly init zsh)"

# direnv
eval "$(direnv hook zsh)"
```

## Troubleshooting

### Tools require Rust/Cargo

Many modern tools are written in Rust. If installation fails:

```bash
# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Then install tools
cargo install eza zoxide procs dust sd choose gping bandwhich tokei hyperfine mcfly atuin
```

### Permission Issues

Some tools need elevated permissions:

```bash
# bandwhich needs sudo
sudo bandwhich

# Add to sudoers for passwordless use (optional)
echo "$USER ALL=(ALL) NOPASSWD: /usr/local/bin/bandwhich" | sudo tee /etc/sudoers.d/bandwhich
```

### Configuration Not Applied

Make sure to source your shell config:

```bash
source ~/.bashrc  # or
source ~/.zshrc
```

Or restart your terminal.

## Summary

These tools represent the collective wisdom of thousands of terminal users:

- **File Management:** lf, ranger, nnn, broot
- **System Monitoring:** btop++, glances, procs, duf, dust
- **Git Enhancement:** lazygit, tig, gh, delta
- **Text Processing:** sd, choose, difftastic, eza
- **Network Tools:** gping, bandwhich, dog
- **Archives:** ouch
- **Essential Utils:** zoxide, hyperfine, tokei, mcfly, atuin

Install them all and see why these are the tools power users can't live without!
