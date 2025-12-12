# Hacker Essentials Guide

**Complete toolkit based on Reddit, StackOverflow, YouTube, and "A Hacker's Must-Have Terminal" posts**

## Overview

This guide covers 40+ essential tools that security researchers, system administrators, developers, and power users consider indispensable. Based on extensive research from:

- **Reddit communities:** r/hacking, r/netsec, r/sysadmin, r/commandline
- **StackOverflow discussions:** Top-voted CLI tool recommendations
- **YouTube channels:** NetworkChuck, LiveOverflow, IppSec, John Hammond
- **Blog posts:** "A Hacker's Must-Have Terminal Tools" compilations

## Installation

```bash
cd .floppies
./install.sh
# Select option 3 (Custom Installation)
# Select option 14 (Hacker Essentials)
```

## Network Analysis Tools

### Essential Scanning

| Tool | Purpose | Why It's Essential |
|------|---------|-------------------|
| **nmap** | Network scanner | Industry standard, every pentester uses it |
| **masscan** | Fast port scanner | Scans entire internet in <6 minutes |
| **rustscan** | Modern port scanner | 10x faster than nmap for initial scans |
| **zmap** | Internet-wide scanner | Research-grade scanning tool |

**Usage Examples:**
```bash
# Quick scan with nmap
nmap -sV -sC target.com

# Fast discovery with rustscan
rustscan -a 192.168.1.0/24 -- -sV

# Masscan for large ranges
masscan -p1-65535 10.0.0.0/8 --rate=10000
```

### Packet Analysis

| Tool | Purpose | Why It's Essential |
|------|---------|-------------------|
| **wireshark** | Packet analyzer GUI | Deep protocol analysis |
| **tshark** | Wireshark CLI | Scriptable packet analysis |
| **tcpdump** | Packet capture | Universal packet sniffer |
| **termshark** | Terminal UI for tshark | Wireshark experience in terminal |

**Usage Examples:**
```bash
# Capture HTTP traffic
tcpdump -i en0 port 80 -w capture.pcap

# Analyze with termshark
termshark -r capture.pcap

# Extract HTTP requests
tshark -r capture.pcap -Y http.request -T fields -e http.host -e http.request.uri
```

### Modern Network Tools

| Tool | Purpose | Community Rating |
|------|---------|-----------------|
| **gping** | Ping with graph | "Can't believe I lived without this" |
| **bandwhich** | Bandwidth by process | "Essential for debugging" |
| **dog** | Modern dig | "Way better than dig" |
| **mtr** | traceroute + ping | "The only network diagnostic tool you need" |

**Usage Examples:**
```bash
# Visual ping
gping google.com 1.1.1.1

# See what's using bandwidth
sudo bandwhich

# Better DNS lookups
dog google.com

# Network path analysis
mtr google.com
```

## Reverse Engineering & Binary Analysis

### Disassemblers & Debuggers

| Tool | Purpose | Use Case |
|------|---------|----------|
| **radare2** | Disassembler framework | Binary analysis, exploit dev |
| **rizin** | Radare2 fork | More active development |
| **gdb** | GNU Debugger | System-level debugging |
| **lldb** | LLVM Debugger | macOS/iOS debugging |
| **ghidra** | NSA decompiler | Free IDA Pro alternative |

**Workflow Example:**
```bash
# Analyze binary with radare2
r2 -A binary
> afl  # list functions
> pdf @ main  # disassemble main
> VV  # visual mode

# Debug with gdb
gdb ./program
(gdb) break main
(gdb) run
(gdb) disas
```

### Binary Utilities

| Tool | Purpose | Why Essential |
|------|---------|--------------|
| **binwalk** | Firmware analysis | Extract filesystems from firmware |
| **hexyl** | Modern hex viewer | Beautiful colored output |
| **hexedit** | Interactive hex editor | Quick binary patching |
| **strings** | Extract strings | First step in binary analysis |

**Usage Examples:**
```bash
# Analyze firmware
binwalk firmware.bin
binwalk -e firmware.bin  # extract

# Beautiful hex dump
hexyl binary

# Find interesting strings
strings -n 8 binary | grep -i password
```

## System Debugging & Monitoring

### Process Inspection

| Tool | Purpose | Power User Quote |
|------|---------|-----------------|
| **strace** | System call trace | "Debugging black magic" |
| **ltrace** | Library call trace | "See what functions are called" |
| **lsof** | List open files | "Find what's using a file/port" |
| **pstree** | Process tree | "Understand process relationships" |

**Common Debugging Scenarios:**
```bash
# See what a program is doing
strace -e trace=network curl google.com

# Find what's using port 8080
lsof -i :8080

# Find all files a process has open
lsof -p <PID>

# Trace library calls
ltrace -f ./program
```

### System Monitoring

| Tool | Purpose | Community Favorite |
|------|---------|-------------------|
| **htop** | Interactive process viewer | Classic, reliable |
| **btop++** | Beautiful resource monitor | Modern, gorgeous |
| **bottom** | Graphical process monitor | Rust-based, fast |
| **glances** | System monitor with Web UI | Remote monitoring |

**Usage:**
```bash
# Traditional
htop

# Modern beauty
btop

# Rust alternative
btm

# With web interface
glances -w
```

## File & Text Processing

### Modern Unix Tools

| Traditional | Modern Alternative | Why Better |
|------------|-------------------|-----------|
| ls | **eza** (exa successor) | Colors, git integration, icons |
| cat | **bat** | Syntax highlighting, git integration |
| cd | **zoxide** | Learns your patterns, 10-15x faster |
| grep | **ripgrep (rg)** | Blazing fast, respects .gitignore |
| find | **fd** | Simpler syntax, faster |
| du | **dust** | Tree view, easier to read |
| df | **duf** | Pretty output, easier to read |
| sed | **sd** | Simpler syntax, safer |

**Productivity Boost:**
```bash
# Old way
cd ~/projects/work/important/project/src/components

# New way (after visiting once)
z comp  # zoxide jumps there

# Old way
grep -r "function" . --include="*.js"

# New way
rg "function" -t js

# Old way
find . -name "*.log" -type f

# New way
fd '\.log$'
```

## Archive & Compression

| Tool | Purpose | Why It Matters |
|------|---------|---------------|
| **ouch** | Universal archiver | One tool for all formats |
| **p7zip** | 7z support | Best compression ratio |
| **pigz** | Parallel gzip | Multi-core compression |
| **pv** | Pipe viewer | See progress in pipes |

**Examples:**
```bash
# Extract anything
ouch decompress archive.tar.gz
ouch decompress firmware.zip
ouch decompress data.7z

# Compress with progress
tar cf - directory | pv | gzip > archive.tar.gz

# Fast parallel compression
tar cf - directory | pigz > archive.tar.gz
```

## Text Processing & Data

| Tool | Purpose | Use Case |
|------|---------|----------|
| **jq** | JSON processor | Parse JSON from APIs |
| **yq** | YAML processor | Work with YAML configs |
| **fx** | Interactive JSON | Explore JSON interactively |
| **gron** | Make JSON greppable | Flatten JSON for grepping |
| **xsv** | CSV toolkit | Process CSV files |

**Real-World Examples:**
```bash
# Extract from JSON API
curl api.github.com/users/username | jq '.name'

# Interactive exploration
cat data.json | fx

# Make JSON greppable
cat data.json | gron | grep "email"

# CSV operations
xsv select name,email users.csv | xsv search 'gmail'
```

## Security & Pentesting

### Web Security

```bash
# Subdomain enumeration (install sublist3r, amass separately)
# SQL injection (install sqlmap separately)
# Directory bruteforce (install gobuster, ffuf separately)
```

### Network Security

```bash
# Exploit databases
searchsploit apache 2.4

# Metasploit (install separately)
# Burp Suite (install separately)
```

## File Synchronization

### Todo.txt GitHub Sync (Android)

**Setup for cross-platform todo.txt sync:**

1. **On Desktop:**
```bash
cd ~/.todo
git init
git add todo.txt done.txt
git commit -m "Initial todo list"
git remote add origin git@github.com:username/todo-sync.git
git push -u origin main
```

2. **On Android (Termux):**
```bash
pkg install git openssh
ssh-keygen
cat ~/.ssh/id_rsa.pub  # Add to GitHub

git clone git@github.com:username/todo-sync.git ~/.todo
```

3. **Auto-sync script (~/.termux/tasker/sync-todo.sh):**
```bash
#!/data/data/com.termux/files/usr/bin/bash
cd ~/.todo
git pull
git add -A
git commit -m "Sync $(date)"
git push
```

4. **Setup Termux:Tasker** to run sync script on schedule

### Other Sync Tools

| Tool | Purpose | Best For |
|------|---------|----------|
| **syncthing** | P2P file sync | Private, no cloud |
| **rclone** | Cloud sync | Multiple cloud providers |
| **rsync** | File sync protocol | Server-to-server |
| **croc** | File transfer | Quick device-to-device |

## Cross-Platform CLI Tools

### Code Analysis

| Tool | Purpose | Speed |
|------|---------|-------|
| **tokei** | Count lines of code | Ultra-fast |
| **scc** | Code complexity | More metrics than tokei |
| **cloc** | Classic counter | Widely used |

```bash
# Fast code stats
tokei

# Detailed metrics
scc

# Classic approach
cloc .
```

### Benchmarking

```bash
# Compare command performance
hyperfine 'rg pattern' 'grep -r pattern'

# Test network speed
iperf3 -c server.com

# Measure command time with progress
time pv large-file.db | command
```

## Hacker Workflow Examples

### Network Reconnaissance

```bash
# 1. Discover hosts
rustscan -a 192.168.1.0/24

# 2. Detailed scan
nmap -sV -sC -oA results target

# 3. Traffic analysis
sudo tcpdump -i eth0 -w capture.pcap host target

# 4. Analyze capture
termshark -r capture.pcap
```

### Binary Analysis

```bash
# 1. Initial recon
file binary
strings binary | less

# 2. Detailed analysis
hexyl binary | less

# 3. Disassemble
radare2 -A binary

# 4. Debug
gdb binary
```

### System Investigation

```bash
# 1. What's running
btop

# 2. What's using network
sudo bandwhich

# 3. What's using files
lsof -i -n

# 4. Trace behavior
strace -f -e trace=network,file program
```

## Mobile Hacking (Android/Termux)

### Essential Termux Setup

```bash
# Update packages
pkg update && pkg upgrade

# Install essentials
pkg install git openssh python nodejs ruby go rust
pkg install nmap masscan radare2 binwalk
pkg install tmux vim neovim
pkg install htop ncdu fd ripgrep bat

# Install ntodotxt for todo.txt
pip install ntodotxt
```

### Termux for Penetration Testing

```bash
# Network tools
pkg install nmap netcat-openbsd socat dnsutils

# Web testing
pip install requests beautifulsoup4

# WiFi analysis (requires root)
pkg install aircrack-ng
```

## Resources

### Learning

- **TryHackMe:** Interactive cybersecurity training
- **HackTheBox:** Penetration testing labs
- **OverTheWire:** Wargames for learning
- **PentesterLab:** Web penetration testing

### Communities

- **Reddit:** r/netsec, r/hacking, r/sysadmin, r/commandline
- **Discord:** Many security-focused servers
- **YouTube:** IppSec, John Hammond, LiveOverflow, NetworkChuck

### Books

- "The Linux Command Line" - William Shotts
- "Hacking: The Art of Exploitation" - Jon Erickson
- "Black Hat Python" - Justin Seitz
- "The Web Application Hacker's Handbook" - Stuttard & Pinto

## Performance Comparisons

### Search Speed
- **ripgrep:** 10-20x faster than grep
- **fd:** 5-10x faster than find
- **zoxide:** 10-15x faster than autojump

### Compression Speed
- **pigz:** Near-linear scaling with CPU cores
- **pv:** Adds <1% overhead while showing progress

### Scanning Speed
- **rustscan:** Initial port discovery in seconds
- **masscan:** Full internet scan in minutes
- **nmap:** Thorough but slower (use after rustscan)

## Tips from the Community

### Top Reddit Quotes

> "Once you use ripgrep, you can never go back to grep" - r/commandline

> "zoxide changed my terminal workflow forever" - r/terminal

> "btop++ is art, not just a system monitor" - r/unixporn

> "strace is the first thing I reach for when debugging" - r/sysadmin

> "termshark brings Wireshark power to SSH sessions" - r/netsec

### StackOverflow Top Answers

1. **Always use `ripgrep` for code searches**
2. **`jq` is essential for working with APIs**
3. **`tmux` is non-negotiable for remote work**
4. **Learn `strace` and `lsof` for debugging**
5. **`bat` with syntax highlighting saves time**

## Conclusion

This collection represents tools that thousands of security professionals, system administrators, and power users consider essential. They're battle-tested, actively maintained, and significantly improve productivity.

**Installation:**
```bash
./install.sh
# Select Custom Installation → Hacker Essentials
```

**Next Steps:**
1. Practice with each category
2. Integrate into daily workflow
3. Automate repetitive tasks
4. Share knowledge with community

---

*"The best tool is the one you know how to use. Master these essentials, and you'll be unstoppable."*
