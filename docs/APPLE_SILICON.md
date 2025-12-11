# Apple Silicon (M1/M2/M3) Support

## Full Compatibility

.floppies **fully supports** both Intel and Apple Silicon Macs:

✅ **Intel Macs** (x86_64)  
✅ **Apple Silicon** (M1, M2, M3, M4 - arm64)

## Automatic Detection

The installer automatically detects your Mac's architecture and configures everything appropriately:

```bash
# Automatic architecture detection
uname -m
# Intel: x86_64
# Apple Silicon: arm64
```

## Key Differences

### Homebrew Installation Path

**Intel Macs:**
- Path: `/usr/local/bin/brew`
- Prefix: `/usr/local`

**Apple Silicon Macs:**
- Path: `/opt/homebrew/bin/brew`
- Prefix: `/opt/homebrew`

The installer automatically sets up the correct paths in your shell configuration.

### Rosetta 2

Some x86_64 applications can run on Apple Silicon through Rosetta 2:

```bash
# Install Rosetta 2 (if needed)
softwareupdate --install-rosetta
```

## Installation on Apple Silicon

### Standard Installation

```bash
git clone https://github.com/professoroakz/.floppies.git
cd .floppies
./install.sh
```

The installer will:
1. Detect Apple Silicon architecture
2. Install Homebrew to `/opt/homebrew`
3. Configure shell PATH for Apple Silicon
4. Install native arm64 packages when available
5. Fall back to x86_64 with Rosetta 2 when needed

### Shell Configuration

The installer adds this to your shell configuration:

```bash
# For Apple Silicon
if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# For Intel
if [ -f /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi
```

## Package Compatibility

### Native arm64 Support

Most packages have native Apple Silicon builds:

✅ **Fully Native:**
- Node.js (via nvm)
- Python (via pyenv)
- Ruby (via rbenv)
- Go
- Rust
- Git
- Docker Desktop
- VSCode
- All modern CLI tools (ripgrep, fd, bat, etc.)

⚠️ **Via Rosetta 2:**
- Some older or niche packages
- Legacy x86_64-only tools

### Version Managers

All version managers work natively:

- **nvm** - Node.js versions are native arm64
- **pyenv** - Python builds natively for arm64
- **rbenv** - Ruby builds natively for arm64
- **rustup** - Rust toolchain is native arm64

## Performance

### Apple Silicon Advantages

🚀 **Significantly Faster:**
- Compilation (Go, Rust builds)
- Package installation
- Development builds
- Container operations
- Battery efficiency

### Benchmarks

Typical improvements on M1/M2 vs Intel i7:
- **npm install**: ~2-3x faster
- **Docker builds**: ~2-4x faster
- **Rust compile**: ~3-5x faster
- **Python builds**: ~2-3x faster

## Docker on Apple Silicon

Docker Desktop for Mac has excellent Apple Silicon support:

```bash
# Install Docker Desktop
brew install --cask docker

# Verify architecture
docker version
# Server: linux/arm64/v8
```

### Multi-Architecture Builds

```bash
# Build for multiple architectures
docker buildx build --platform linux/amd64,linux/arm64 -t myapp .

# Run x86_64 containers (via emulation)
docker run --platform linux/amd64 ubuntu
```

## Troubleshooting

### Homebrew Not Found

If you see "command not found: brew" after installation:

```bash
# For Apple Silicon
eval "$(/opt/homebrew/bin/brew shellenv)"

# Add to shell profile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
```

### Architecture Mismatch

Check your architecture:

```bash
# Your Mac's architecture
uname -m

# Check what architecture a binary is
file /opt/homebrew/bin/node
# Should show: Mach-O 64-bit executable arm64

# Check Homebrew architecture
brew config | grep "CPU:"
# Should show: arm64
```

### Package Not Available

If a package isn't available for arm64:

```bash
# Try installing with Rosetta 2
arch -x86_64 brew install <package>

# Or use Docker
docker run --platform linux/arm64 <image>
```

### Xcode Command Line Tools

Essential for compilation:

```bash
# Install Xcode Command Line Tools
xcode-select --install

# Verify installation
xcode-select -p
# Should show: /Library/Developer/CommandLineTools
```

## Migration from Intel to Apple Silicon

If you're migrating from an Intel Mac:

### 1. Backup Data

```bash
# Backup your development environment
Time Machine or manual backup
```

### 2. Clean Install Recommended

For best performance, do a clean install rather than migration:

```bash
# On new Apple Silicon Mac
git clone https://github.com/professoroakz/.floppies.git
cd .floppies
./install.sh
```

### 3. Reinstall Native Versions

Don't migrate Intel Homebrew packages:

```bash
# Remove old Intel Homebrew (if migrated)
rm -rf /usr/local/Homebrew

# Use .floppies to install fresh
./install.sh
```

### 4. Rebuild Version Manager Installations

```bash
# Rebuild Node.js for arm64
nvm uninstall <version>
nvm install <version>

# Rebuild Python for arm64
pyenv uninstall <version>
pyenv install <version>

# Rebuild Ruby for arm64
rbenv uninstall <version>
rbenv install <version>
```

## Development Experience

### Terminal Performance

Apple Silicon Macs have exceptional terminal performance:

- Faster command execution
- Better responsiveness
- Improved battery life during development
- Cool and quiet operation

### Recommended Terminals

All support Apple Silicon natively:

1. **iTerm2** - Most popular (installed by .floppies)
2. **Warp** - Modern, GPU-accelerated
3. **Alacritty** - Fastest, minimal
4. **Kitty** - Feature-rich, fast
5. **Terminal.app** - Built-in, native

### Memory Efficiency

Apple Silicon's unified memory architecture:

- Faster memory access
- Better VM/container performance
- Can run more concurrent processes
- 16GB feels like 32GB on Intel

## Best Practices

### 1. Always Use Native Builds

```bash
# Check if package is native
file $(which node)
# Should include: arm64

# Install native packages
brew install <package>
```

### 2. Update Regularly

```bash
# Keep everything updated
brew update && brew upgrade

# Update .floppies
cd .floppies
git pull
./install.sh
```

### 3. Use Native Tools

Prefer native arm64 tools:
- ✅ Rust (native)
- ✅ Go (native)
- ✅ Node.js (native via nvm)
- ⚠️ Avoid old x86_64-only tools

### 4. Docker Best Practices

```bash
# Use arm64 base images
FROM arm64v8/ubuntu:22.04

# Or multi-arch images
FROM --platform=$BUILDPLATFORM ubuntu:22.04
```

## Known Limitations

### Very Rare Issues

1. **Old Java versions** - Use Java 11+ for best support
2. **Legacy packages** - Some abandoned packages may not work
3. **Closed-source binaries** - x86_64-only binaries need Rosetta 2

### Workarounds

```bash
# Run x86_64 shell for compatibility
arch -x86_64 zsh

# Install Intel Homebrew alongside (not recommended)
arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Resources

- **Apple Silicon Guide**: https://github.com/github/brew-app
- **Homebrew Apple Silicon**: https://docs.brew.sh/Installation
- **Docker Desktop**: https://www.docker.com/products/docker-desktop

## Verification

Verify your setup:

```bash
# Check architecture
uname -m
# Expected: arm64

# Check Homebrew
brew config | grep "CPU:"
# Expected: CPU: arm64

# Check Node.js
node -p "process.arch"
# Expected: arm64

# Check Python
python3 -c "import platform; print(platform.machine())"
# Expected: arm64

# Check Docker
docker version | grep "OS/Arch"
# Expected: linux/arm64
```

---

.floppies provides seamless Apple Silicon support out of the box! 🚀
