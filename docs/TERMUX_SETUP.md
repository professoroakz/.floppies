# Termux Setup Guide

## About Termux

Termux is a powerful terminal emulator and Linux environment for Android. .floppies can be used in Termux to set up a complete development environment on your Android device.

## Installation on Android/Termux

### 1. Install Termux

Download Termux from [F-Droid](https://f-droid.org/en/packages/com.termux/) (recommended) or [Google Play Store](https://play.google.com/store/apps/details?id=com.termux).

**Note:** F-Droid version is recommended as it receives more frequent updates.

### 2. Initial Termux Setup

```bash
# Update packages
pkg update && pkg upgrade

# Install essential packages
pkg install git curl wget openssh

# Install additional tools
pkg install python nodejs ruby golang rust

# Grant storage access (optional)
termux-setup-storage
```

### 3. Install .floppies

```bash
# Clone the repository
git clone https://github.com/professoroakz/.floppies.git
cd .floppies

# Run the installer
./install.sh
```

### 4. Select Installation Type

For Termux, we recommend:
- **Option 2: Core Essentials** - For basic development
- **Option 3: Custom** - Select specific components you need

**Note:** Some tools may not be available or work differently on Android/Termux.

## Termux-Specific Features

### Available Tools

✅ **Working Well:**
- Git, SSH, GPG
- Node.js, Python, Ruby, Go, Rust
- Vim, Neovim, Micro editor
- tmux, screen
- Modern CLI tools (ripgrep, fd, bat, exa, fzf)
- jq, yq, curl, wget

⚠️ **Limited or Not Available:**
- Docker (not supported on Android)
- VSCode (use code-server instead)
- Some GUI applications

### Termux-Specific Setup

#### Install Additional Termux Packages

```bash
# Development tools
pkg install clang make cmake

# Databases
pkg install postgresql mariadb

# Text editors
pkg install vim neovim micro

# Networking
pkg install nmap openssh rsync
```

#### Code Server (VS Code for Web)

```bash
# Install code-server for web-based VSCode
curl -fsSL https://code-server.dev/install.sh | sh

# Run code-server
code-server
# Access at http://localhost:8080
```

#### Termux:API (Optional)

For advanced Android integration:

```bash
# Install Termux:API app from F-Droid
# Then install API package
pkg install termux-api

# Examples
termux-battery-status    # Battery info
termux-location          # GPS location
termux-notification      # Send notifications
termux-camera-photo      # Take photos
```

## Termux Configuration

### Custom Bash Configuration

```bash
# Edit ~/.bashrc
cat >> ~/.bashrc << 'EOF'

# Termux-specific aliases
alias storage='cd /storage/emulated/0'
alias downloads='cd /storage/emulated/0/Download'
alias dcim='cd /storage/emulated/0/DCIM'

# Python shortcut
alias python='python3'

# Update all
alias update-all='pkg update && pkg upgrade && pip install --upgrade pip'

# Custom prompt
PS1='\[\033[01;32m\]\u@termux\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
EOF
```

### Storage Access

```bash
# Allow Termux to access device storage
termux-setup-storage

# This creates ~/storage/ with symlinks to:
# ~/storage/shared      - Internal storage
# ~/storage/downloads   - Downloads folder
# ~/storage/dcim        - Camera photos
# ~/storage/pictures    - Pictures
# ~/storage/music       - Music
```

## Development Workflow on Termux

### 1. SSH Access

Set up SSH to access Termux from your computer:

```bash
# Install and start SSH server
pkg install openssh
sshd

# Find your device IP
ifconfig

# From your computer:
# ssh -p 8022 u0_a123@192.168.1.x
```

### 2. Git Configuration

```bash
# Configure Git
git config --global user.name "Your Name"
git config --global user.email "your@email.com"

# Generate SSH key
ssh-keygen -t ed25519 -C "your@email.com"

# Copy public key to GitHub
cat ~/.ssh/id_ed25519.pub
```

### 3. Project Development

```bash
# Create projects directory
mkdir -p ~/projects
cd ~/projects

# Clone and work on projects
git clone https://github.com/user/repo.git
cd repo

# Development tools work normally
npm install
python manage.py runserver
```

## Termux Limitations

1. **No Docker**: Docker requires kernel features not available on Android
2. **No systemd**: Use `sv` or manual process management
3. **Different paths**: No `/usr/bin`, everything is in `$PREFIX`
4. **Battery**: Long-running processes may drain battery
5. **Background limits**: Android may kill background processes

## Performance Tips

### 1. Wake Lock

Keep Termux running in background:

```bash
# Install Termux:Boot for auto-start
# Install Termux:Widget for quick actions
```

### 2. Resource Management

```bash
# Monitor resources
htop

# Check processes
ps aux

# Kill heavy processes
pkill <process-name>
```

### 3. Storage Optimization

```bash
# Clean package cache
pkg clean

# Remove unnecessary packages
pkg autoclean
```

## Integration with Other Apps

### Termux:Widget

Create shortcuts for common tasks:

```bash
# Create widget scripts directory
mkdir -p ~/.shortcuts

# Create example script
cat > ~/.shortcuts/update-all.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
pkg update && pkg upgrade -y
EOF

chmod +x ~/.shortcuts/update-all.sh
```

### Termux:Tasker

Automate Termux with Tasker:

```bash
# Create Tasker directory
mkdir -p ~/.termux/tasker
```

## Troubleshooting

### Package Installation Fails

```bash
# Update repository information
pkg update

# Clear cache
pkg clean

# Try again
pkg install <package>
```

### Permission Denied

```bash
# Check permissions
ls -l <file>

# Fix permissions
chmod +x <file>
```

### Out of Space

```bash
# Check space
df -h

# Clean up
pkg clean
apt autoremove
```

## Advanced Usage

### Run Linux Distributions

Use proot-distro to run full Linux distributions:

```bash
pkg install proot-distro

# Install Ubuntu
proot-distro install ubuntu

# Login to Ubuntu
proot-distro login ubuntu
```

### Run Desktop Environment

```bash
# Install VNC server
pkg install x11-repo
pkg install tigervnc

# Install desktop environment (XFCE)
pkg install xfce4

# Start VNC server
vncserver

# Connect with VNC viewer app to localhost:5901
```

## Resources

- **Termux Wiki**: https://wiki.termux.com/
- **Termux GitHub**: https://github.com/termux
- **F-Droid**: https://f-droid.org/en/packages/com.termux/
- **Community**: https://gitter.im/termux/termux

## Recommended Apps

Install these companion apps for best experience:

1. **Termux** - Main terminal
2. **Termux:API** - Android integration
3. **Termux:Boot** - Auto-start on device boot
4. **Termux:Float** - Floating terminal window
5. **Termux:Styling** - Color schemes and fonts
6. **Termux:Tasker** - Tasker integration
7. **Termux:Widget** - Home screen widgets

All available on F-Droid: https://f-droid.org/en/packages/

---

For more help, see the main [README](../README.md) and [FAQ](FAQ.md).
