# Productivity Tools Guide

Complete guide to the productivity tools installed by .floppies, including AI CLIs, note-taking, todo management, communication tools, password managers, image viewers, and self-hosting capabilities.

## Table of Contents

- [AI CLI Tools](#ai-cli-tools)
- [Note-Taking Tools](#note-taking-tools)
- [Todo Management](#todo-management)
- [Communication Tools](#communication-tools)
- [Password Managers](#password-managers)
- [Terminal Image Viewers](#terminal-image-viewers)
- [Self-Hosting Tools](#self-hosting-tools)
- [Productivity Apps](#productivity-apps)

---

## AI CLI Tools

### GitHub Copilot CLI

Interact with GitHub Copilot from your terminal.

```bash
# Install (done automatically)
npm install -g @githubnext/github-copilot-cli

# Usage
github-copilot-cli "how do I list all files recursively"
```

### ChatGPT CLI

Unofficial ChatGPT CLI for terminal interactions.

```bash
# Usage
chatgpt "explain this code"
```

### Shell-GPT (sgpt)

GPT-powered shell command generation and execution.

```bash
# Generate shell commands
sgpt "find all large files in current directory"

# Execute directly with --shell
sgpt --shell "compress all logs older than 30 days"

# Code generation
sgpt --code "python function to parse JSON"
```

### Aider

AI pair programming in your terminal.

```bash
# Start coding session
aider

# Edit specific files
aider file1.py file2.py

# Use different models
aider --model gpt-4
```

### GPT-Commit

Generate AI-powered commit messages.

```bash
# Generate commit message
gpt-commit

# Auto-commit with generated message
gpt-commit --auto
```

**Setup Required:** Most AI tools require API keys. Set environment variables:

```bash
export OPENAI_API_KEY="your-key-here"
export ANTHROPIC_API_KEY="your-key-here"  # For Claude
```

---

## Note-Taking Tools

### Obsidian

Powerful markdown-based knowledge base (GUI app).

- **Location:** `/Applications/Obsidian.app` (macOS)
- **Sync:** Use Syncthing, Git, or Obsidian Sync
- **Plugins:** Community plugins available in app

### Standard Notes

End-to-end encrypted note-taking app.

- Simple, secure, cross-platform
- Self-hostable sync server available

### Joplin

Open-source note-taking with sync capabilities.

```bash
# CLI usage
joplin

# Create note
joplin mknote "My Note"

# Search notes
joplin search "keyword"
```

### Markdown CLI Tools

#### Glow - Markdown Viewer

```bash
# View markdown file
glow README.md

# View with pager
glow -p file.md

# Render all markdown in directory
glow .
```

#### Pandoc - Universal Document Converter

```bash
# Convert markdown to PDF
pandoc input.md -o output.pdf

# Convert to Word
pandoc input.md -o output.docx

# Convert to HTML
pandoc input.md -o output.html
```

### jrnl - Command Line Journal

```bash
# Initialize
jrnl

# Add entry
jrnl Today I learned about Docker.

# Add entry with tags
jrnl Today I finished the project @work @important

# View entries
jrnl -from "last week" -to today

# Export to markdown
jrnl --export markdown -o journal.md
```

---

## Todo Management

### todo.txt-cli

Simple, powerful todo list management.

```bash
# Add task
todo.sh add "Buy groceries @shopping"

# List tasks
todo.sh ls

# List by priority
todo.sh ls @work

# Complete task
todo.sh do 5

# Archive completed tasks
todo.sh archive
```

**Configuration:** `~/.todo/config`

### Taskwarrior

Advanced task management system.

```bash
# Add task
task add "Write documentation" project:floppies

# List tasks
task list

# Start task
task 1 start

# Complete task
task 1 done

# Reports
task burndown.daily
task summary
```

### Memo

Simple memo/note CLI tool.

```bash
# New memo
memo new

# List memos
memo list

# Search memos
memo grep "keyword"

# Edit memo
memo edit 1
```

### Taskbook

Tasks and notes for the command line.

```bash
# Add task
tb -t "Complete project documentation"

# Add note
tb -n "Meeting notes from today"

# Mark complete
tb -c 1

# List all
tb
```

### Todoist CLI (Python)

Interact with Todoist from terminal.

```bash
# Install
pip3 install todoist-python

# Use via Python
python3
>>> from todoist_api_python.api import TodoistAPI
>>> api = TodoistAPI("your-token")
>>> tasks = api.get_tasks()
```

---

## Communication Tools

### Slack

Team communication platform (GUI + CLI).

```bash
# Slack CLI (install from https://api.slack.com/automation/cli)
slack login
slack run workflow
```

### Telegram

Secure messaging app with desktop client installed.

- Desktop app: `/Applications/Telegram.app` (macOS)
- CLI via telegram-cli or telethon

### Signal

Privacy-focused messaging app.

- Desktop app installed
- E2E encrypted by default

### Discord

Community chat and voice.

- Desktop app installed
- Great for communities and projects

### Element (Matrix)

Decentralized, secure communication.

- Open source, self-hostable
- Bridge to other services

### Status

Decentralised wallet and messenger built on Ethereum.

- Secure messaging with E2E encryption
- Built-in cryptocurrency wallet
- DApp browser for Web3 applications
- **macOS:** Automatically installed on Apple Silicon. Intel Mac users should download from [status-desktop releases](https://github.com/status-im/status-desktop/releases)
- Desktop app: `/Applications/Status.app` (macOS)

---

## Password Managers

### Bitwarden

Open-source password manager with CLI.

```bash
# Login
bw login

# Unlock vault
bw unlock

# Get password
bw get password github.com

# Add item
bw create item '{"name":"Example","login":{"username":"user","password":"pass"}}'

# Sync
bw sync
```

### 1Password CLI

```bash
# Sign in
op signin

# Get password
op item get "GitHub" --fields password

# Create item
op item create --category=login --title="Example" \
  username=user password=secret url=example.com
```

### pass (Unix Password Manager)

GPG-encrypted password store.

```bash
# Initialize
pass init your-gpg-id

# Add password
pass insert email/gmail

# Retrieve password
pass email/gmail

# Generate password
pass generate social/twitter 20

# Copy to clipboard
pass -c email/gmail
```

### gopass

Team password manager built on pass.

```bash
# Initialize
gopass init

# Add password
gopass insert team/database

# Search
gopass search database

# Generate password
gopass generate -n 20 team/api-key
```

---

## Terminal Image Viewers

### imgcat (iTerm2)

Display images directly in iTerm2.

```bash
# View image
imgcat photo.jpg

# View from URL
curl -s https://example.com/image.png | imgcat
```

### viu

Cross-platform terminal image viewer.

```bash
# View image
viu image.png

# View with specific width
viu -w 80 image.png

# Transparent background
viu -t image.png
```

### chafa

Character art generator for terminal.

```bash
# View image
chafa photo.jpg

# Specific size
chafa --size 80x40 photo.jpg

# High quality
chafa --symbols block photo.jpg

# Animated GIF support
chafa animation.gif
```

### timg

Terminal image and video viewer with sixel support.

```bash
# View image
timg image.png

# View video frames
timg video.mp4

# Grid view
timg *.jpg -g 4x3
```

### catimg

ASCII art image viewer.

```bash
# View as ASCII
catimg photo.jpg

# Colored ASCII
catimg -c photo.jpg
```

**Terminal Support:**
- **iTerm2:** Full sixel and inline images
- **Kitty:** Graphics protocol support
- **Warp:** Image preview support
- **Alacritty:** Limited support
- **Standard terminals:** ASCII art via catimg/chafa

---

## Self-Hosting Tools

### Docker & Docker Compose

Foundation for self-hosted services (already installed).

```bash
# Example: Run Vaultwarden (Bitwarden)
docker run -d --name vaultwarden \
  -v /vw-data/:/data/ \
  -p 80:80 \
  vaultwarden/server:latest
```

### Caddy

Modern web server with automatic HTTPS.

```bash
# Start Caddy
caddy start

# Reverse proxy example
caddy reverse-proxy --from example.com --to localhost:3000
```

**Caddyfile example:**

```
example.com {
    reverse_proxy localhost:3000
}
```

### Nginx

Popular web server and reverse proxy.

```bash
# Start nginx
nginx

# Test configuration
nginx -t

# Reload
nginx -s reload
```

### Syncthing

Continuous file synchronization.

```bash
# Start Syncthing
syncthing

# Access web UI at http://localhost:8384
```

**Perfect for:**
- Obsidian vault sync
- Photo sync between devices
- Document synchronization

### Tailscale

Secure network for self-hosted services.

```bash
# Connect
sudo tailscale up

# Check status
tailscale status

# Access services via secure network
curl http://100.x.x.x:8080
```

### Popular Self-Hosted Apps (via Docker)

#### Vaultwarden (Bitwarden Server)

```bash
docker run -d --name vaultwarden \
  -e WEBSOCKET_ENABLED=true \
  -v /vw-data/:/data/ \
  -p 80:80 \
  vaultwarden/server:latest
```

#### Nextcloud (File Sync)

```bash
docker run -d \
  -v nextcloud:/var/www/html \
  -p 8080:80 \
  nextcloud
```

#### Gitea (Git Hosting)

```bash
docker run -d --name=gitea \
  -p 3000:3000 \
  -p 222:22 \
  -v /var/lib/gitea:/data \
  gitea/gitea:latest
```

#### Miniflux (RSS Reader)

```bash
docker run -d \
  -p 8080:8080 \
  -e DATABASE_URL=postgres://... \
  miniflux/miniflux:latest
```

#### Paperless-ngx (Document Management)

```bash
docker-compose up -d
# See: https://github.com/paperless-ngx/paperless-ngx
```

---

## Productivity Apps

### macOS Specific

#### Alfred / Raycast

Powerful launchers and productivity tools.

```bash
# Alfred: Ctrl+Space (default)
# Raycast: Cmd+Space (configurable)
```

**Features:**
- App launching
- File search
- Calculator
- Clipboard history
- Custom scripts
- Workflows

#### Rectangle

Window management for macOS.

**Shortcuts:**
- `Ctrl+Opt+Left`: Left half
- `Ctrl+Opt+Right`: Right half
- `Ctrl+Opt+F`: Fullscreen
- `Ctrl+Opt+C`: Center

### Time Tracking

#### Toggl Track

Time tracking app (GUI).

- Start/stop timers
- Project tracking
- Reports and analytics

#### Zeit (CLI)

```bash
# Start timer
zeit start "Working on documentation"

# Stop timer
zeit stop

# Status
zeit status

# Report
zeit report
```

### CLI Productivity Tools

#### fzf - Fuzzy Finder

```bash
# Find file
vim $(fzf)

# Search history
history | fzf

# Change directory
cd $(find . -type d | fzf)
```

#### ripgrep (rg)

Fast grep alternative.

```bash
# Search in files
rg "function" --type py

# Case insensitive
rg -i "TODO"

# Show context
rg -C 3 "error"
```

---

## Workflow Integration Examples

### VSCode + AI + Terminal

```bash
# 1. Open VSCode
code .

# 2. Use Copilot in editor
# 3. Use Aider for refactoring
aider src/main.py

# 4. Generate commit with GPT
gpt-commit
```

### Note-Taking Workflow

```bash
# Quick note
jrnl Today's standup notes @work

# Detailed documentation
obsidian  # Open GUI for long-form

# Quick memo
memo new

# View notes in terminal
glow ~/notes/*.md
```

### Todo Workflow

```bash
# Add todo
todo.sh add "Review PR #123 @github +urgent"

# Check tasks
tb

# Work on task
task 1 start

# Complete
task 1 done
todo.sh do 5
```

### Image Preview Workflow

```bash
# Preview single image
viu screenshot.png

# Preview all images in directory
chafa *.png

# View in grid (timg)
timg *.jpg -g 3x3

# iTerm2 inline
imgcat diagram.png
```

---

## Configuration Tips

### Environment Variables

Add to `~/.bashrc` or `~/.zshrc`:

```bash
# AI Tools
export OPENAI_API_KEY="your-key"
export ANTHROPIC_API_KEY="your-key"

# Todoist
export TODOIST_API_TOKEN="your-token"

# Bitwarden
export BW_SESSION="session-key"

# Default editor
export EDITOR="vim"
export VISUAL="code"
```

### Aliases

Useful aliases for productivity:

```bash
# Quick notes
alias qn='jrnl'
alias note='memo new'

# Todo
alias t='todo.sh'
alias tl='todo.sh ls'
alias ta='todo.sh add'

# Password management
alias pw='bw get password'

# Image preview
alias img='viu'
alias imgs='timg -g 4x3 *.jpg *.png'

# AI help
alias ai='sgpt'
alias explain='sgpt --code'
```

---

## Mobile Support

### Termux (Android)

Full Linux environment on Android with productivity tools.

See: [TERMUX_SETUP.md](TERMUX_SETUP.md)

**Available:**
- All CLI tools
- AI CLIs
- Todo management
- Password managers (CLI)
- Image viewers
- Syncthing for sync

### iOS (Limited)

**Available apps:**
- Obsidian (native)
- Bitwarden (native)
- Todoist (native)
- Signal/Telegram (native)
- iSH (limited shell environment)

---

## Self-Hosting Recommendations

### Essential Services

1. **Vaultwarden** - Password management
2. **Nextcloud** - File sync, calendar, contacts
3. **Syncthing** - File synchronization
4. **Gitea** - Git repository hosting
5. **Miniflux** - RSS reader
6. **Paperless-ngx** - Document management

### Nice to Have

1. **Jellyfin** - Media server
2. **Home Assistant** - Home automation
3. **Bookstack** - Wiki/documentation
4. **Monica** - Personal CRM
5. **Firefly III** - Finance management

### Infrastructure

1. **Tailscale** - Secure networking
2. **Caddy** - Reverse proxy with auto-HTTPS
3. **Portainer** - Docker management UI
4. **Watchtower** - Automatic container updates

---

## Troubleshooting

### AI Tools Not Working

```bash
# Check API key
echo $OPENAI_API_KEY

# Reinstall
npm install -g @githubnext/github-copilot-cli
pip3 install --upgrade shell-gpt
```

### Image Viewers Not Displaying

```bash
# Check terminal support
echo $TERM

# Try different viewer
viu image.png    # Works everywhere
chafa image.png  # ASCII fallback
```

### Password Manager Issues

```bash
# Bitwarden: Re-login
bw logout
bw login

# pass: Check GPG
gpg --list-keys

# gopass: Verify setup
gopass version
```

---

## Additional Resources

- **AI Tools:** [OpenAI API](https://platform.openai.com/)
- **Note-Taking:** [Obsidian Help](https://help.obsidian.md/)
- **Self-Hosting:** [Awesome Self-Hosted](https://github.com/awesome-selfhosted/awesome-selfhosted)
- **Todo:** [Todo.txt Format](http://todotxt.org/)
- **Password Management:** [pass Documentation](https://www.passwordstore.org/)

---

## Quick Reference

```bash
# AI Help
sgpt "your question"
aider file.py

# Notes
jrnl "entry"
glow notes.md

# Todos
todo.sh add "task"
task add "task"

# Passwords
bw get password site
pass site/login

# Images
viu image.png
chafa image.jpg

# Communication
# Use GUI apps installed
```

---

For more information, see the main [README.md](../README.md) and [FAQ](FAQ.md).
