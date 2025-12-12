#!/usr/bin/env bash

# macOS Shortcuts Integration Module
# Automate terminal workflows with macOS Shortcuts app
# Provides shortcuts for common development tasks

set -e

echo "=================================================="
echo "macOS Shortcuts Integration"
echo "=================================================="

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "⚠️  This module is only for macOS"
    exit 0
fi

SHORTCUTS_DIR="$HOME/Library/Shortcuts"
SCRIPTS_DIR="$HOME/.floppies-shortcuts"

# Create scripts directory
mkdir -p "$SCRIPTS_DIR"

echo ""
echo "📱 Installing macOS Shortcuts Integration..."
echo ""

# Create helper scripts for Shortcuts

# 1. Git Quick Commit
cat > "$SCRIPTS_DIR/git-quick-commit.sh" << 'EOF'
#!/usr/bin/env bash
# Quick git commit with AI-generated message (if available)
cd "$1" || exit 1
git add .
if command -v gpt-commit &> /dev/null; then
    gpt-commit
else
    git commit -m "Quick commit: $(date)"
fi
git push
EOF
chmod +x "$SCRIPTS_DIR/git-quick-commit.sh"

# 2. Project Launcher
cat > "$SCRIPTS_DIR/open-project.sh" << 'EOF'
#!/usr/bin/env bash
# Open project in VSCode and start terminal
PROJECT_PATH="$1"
cd "$PROJECT_PATH" || exit 1

# Open in VSCode
if command -v code &> /dev/null; then
    code .
fi

# Open terminal (iTerm2 or Terminal.app)
if command -v osascript &> /dev/null; then
    if [ -d "/Applications/iTerm.app" ]; then
        osascript -e "tell application \"iTerm\" to activate"
        osascript -e "tell application \"iTerm\" to create window with default profile command \"cd $PROJECT_PATH && clear\""
    else
        osascript -e "tell application \"Terminal\" to activate"
        osascript -e "tell application \"Terminal\" to do script \"cd $PROJECT_PATH && clear\""
    fi
fi
EOF
chmod +x "$SCRIPTS_DIR/open-project.sh"

# 3. System Info Quick View
cat > "$SCRIPTS_DIR/system-info.sh" << 'EOF'
#!/usr/bin/env bash
# Get system information for quick view
echo "🖥️  System Information"
echo "===================="
echo ""
echo "🔋 Battery: $(pmset -g batt | grep -Eo "[0-9]+%" | head -1)"
echo "💾 Disk: $(df -h / | awk 'NR==2 {print $5 " used, " $4 " free"}')"
echo "🧠 Memory: $(top -l 1 | awk '/PhysMem/ {print $2 " used, " $6 " free"}')"
echo "🌡️  CPU Load: $(sysctl -n vm.loadavg | awk '{print $2, $3, $4}')"
echo "📶 Network: $(networksetup -listallhardwareports | grep -A1 Wi-Fi | tail -1 | awk '{print $2}')"
if command -v btop &> /dev/null; then
    echo ""
    echo "📊 Run 'btop' for detailed monitoring"
fi
EOF
chmod +x "$SCRIPTS_DIR/system-info.sh"

# 4. Todo Quick Add
cat > "$SCRIPTS_DIR/todo-add.sh" << 'EOF'
#!/usr/bin/env bash
# Quick add to todo.txt
TODO_FILE="$HOME/Dropbox/todo/todo.txt"
if [ ! -f "$TODO_FILE" ]; then
    TODO_FILE="$HOME/.todo/todo.txt"
fi
mkdir -p "$(dirname "$TODO_FILE")"
touch "$TODO_FILE"

TASK="$1"
if [ -z "$TASK" ]; then
    echo "Usage: $0 'Task description'"
    exit 1
fi

echo "$(date +%Y-%m-%d) $TASK" >> "$TODO_FILE"
echo "✅ Added: $TASK"

# Show last 5 todos
echo ""
echo "📋 Recent todos:"
tail -5 "$TODO_FILE"
EOF
chmod +x "$SCRIPTS_DIR/todo-add.sh"

# 5. Docker Quick Manager
cat > "$SCRIPTS_DIR/docker-manager.sh" << 'EOF'
#!/usr/bin/env bash
# Quick Docker management
ACTION="$1"

case "$ACTION" in
    start)
        echo "🐳 Starting Docker containers..."
        docker-compose up -d
        docker ps
        ;;
    stop)
        echo "🛑 Stopping Docker containers..."
        docker-compose down
        ;;
    clean)
        echo "🧹 Cleaning Docker..."
        docker system prune -af --volumes
        ;;
    status)
        echo "📊 Docker Status"
        echo "================"
        docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
        echo ""
        echo "💾 Disk Usage:"
        docker system df
        ;;
    *)
        echo "Usage: $0 {start|stop|clean|status}"
        exit 1
        ;;
esac
EOF
chmod +x "$SCRIPTS_DIR/docker-manager.sh"

# 6. Screenshot Organizer
cat > "$SCRIPTS_DIR/organize-screenshots.sh" << 'EOF'
#!/usr/bin/env bash
# Organize screenshots from Desktop to dated folders
DESKTOP="$HOME/Desktop"
SCREENSHOTS="$HOME/Pictures/Screenshots"
TODAY=$(date +%Y-%m-%d)
DEST="$SCREENSHOTS/$TODAY"

mkdir -p "$DEST"

COUNT=$(find "$DESKTOP" -name "Screen Shot*.png" -o -name "Screenshot*.png" 2>/dev/null | wc -l | xargs)

if [ "$COUNT" -gt 0 ]; then
    find "$DESKTOP" \( -name "Screen Shot*.png" -o -name "Screenshot*.png" \) -exec mv {} "$DEST/" \;
    echo "✅ Organized $COUNT screenshot(s) to $DEST"
else
    echo "ℹ️  No screenshots found on Desktop"
fi
EOF
chmod +x "$SCRIPTS_DIR/organize-screenshots.sh"

# 7. AI Command Helper
cat > "$SCRIPTS_DIR/ai-command.sh" << 'EOF'
#!/usr/bin/env bash
# Get AI help for terminal commands
QUERY="$1"

if [ -z "$QUERY" ]; then
    echo "Usage: $0 'what do you want to do'"
    exit 1
fi

if command -v sgpt &> /dev/null; then
    echo "🤖 AI Suggestion:"
    sgpt --shell "$QUERY"
elif command -v aichat &> /dev/null; then
    echo "🤖 AI Suggestion:"
    aichat "$QUERY"
else
    echo "⚠️  Install Shell-GPT or AIChat for AI assistance"
    echo "Run: brew install shell-gpt"
fi
EOF
chmod +x "$SCRIPTS_DIR/ai-command.sh"

# 8. Network Speed Test
cat > "$SCRIPTS_DIR/speedtest.sh" << 'EOF'
#!/usr/bin/env bash
# Quick network speed test
echo "🌐 Testing network speed..."
if command -v speedtest-cli &> /dev/null; then
    speedtest-cli --simple
elif command -v fast &> /dev/null; then
    fast
else
    echo "Installing speedtest..."
    brew install speedtest-cli
    speedtest-cli --simple
fi
EOF
chmod +x "$SCRIPTS_DIR/speedtest.sh"

# 9. Coffee Break Timer
cat > "$SCRIPTS_DIR/break-timer.sh" << 'EOF'
#!/usr/bin/env bash
# Pomodoro-style break timer
MINUTES="${1:-25}"
SECONDS=$((MINUTES * 60))

echo "⏱️  Starting ${MINUTES} minute timer..."
echo "Press Ctrl+C to cancel"

sleep "$SECONDS"

# Notification
osascript -e "display notification \"Time for a break!\" with title \"Break Timer\" sound name \"Glass\""

# Optional: say it out loud
say "Time for a break"
EOF
chmod +x "$SCRIPTS_DIR/break-timer.sh"

# 10. Clipboard Manager
cat > "$SCRIPTS_DIR/clipboard-manager.sh" << 'EOF'
#!/usr/bin/env bash
# Manage clipboard history
ACTION="$1"
CLIP_DIR="$HOME/.clipboard-history"
mkdir -p "$CLIP_DIR"

case "$ACTION" in
    save)
        TIMESTAMP=$(date +%Y%m%d-%H%M%S)
        pbpaste > "$CLIP_DIR/$TIMESTAMP.txt"
        echo "💾 Clipboard saved as $TIMESTAMP"
        ;;
    list)
        echo "📋 Clipboard History:"
        ls -lt "$CLIP_DIR" | tail -10 | awk '{print $9}' | sed 's/.txt//'
        ;;
    restore)
        LATEST=$(ls -t "$CLIP_DIR" | head -1)
        if [ -n "$LATEST" ]; then
            cat "$CLIP_DIR/$LATEST" | pbcopy
            echo "✅ Restored: $LATEST"
        fi
        ;;
    *)
        echo "Usage: $0 {save|list|restore}"
        ;;
esac
EOF
chmod +x "$SCRIPTS_DIR/clipboard-manager.sh"

echo "✅ Helper scripts installed to $SCRIPTS_DIR"
echo ""

# Install shortcuts CLI helper
if ! command -v shortcuts &> /dev/null; then
    echo "📱 Installing shortcuts CLI..."
    brew install --cask shortcuts
fi

# Create documentation
cat > "$SCRIPTS_DIR/README.md" << 'EOF'
# macOS Shortcuts Integration

Helper scripts for automating terminal workflows with macOS Shortcuts app.

## Available Scripts

### 1. Git Quick Commit
```bash
~/.floppies-shortcuts/git-quick-commit.sh /path/to/repo
```
Auto-commit and push changes with AI-generated message.

### 2. Project Launcher
```bash
~/.floppies-shortcuts/open-project.sh /path/to/project
```
Open project in VSCode and terminal.

### 3. System Info
```bash
~/.floppies-shortcuts/system-info.sh
```
Quick system information overview.

### 4. Todo Quick Add
```bash
~/.floppies-shortcuts/todo-add.sh "Task description"
```
Add task to todo.txt.

### 5. Docker Manager
```bash
~/.floppies-shortcuts/docker-manager.sh {start|stop|clean|status}
```
Manage Docker containers.

### 6. Screenshot Organizer
```bash
~/.floppies-shortcuts/organize-screenshots.sh
```
Organize screenshots from Desktop.

### 7. AI Command Helper
```bash
~/.floppies-shortcuts/ai-command.sh "what I want to do"
```
Get AI assistance for terminal commands.

### 8. Network Speed Test
```bash
~/.floppies-shortcuts/speedtest.sh
```
Test internet speed.

### 9. Break Timer
```bash
~/.floppies-shortcuts/break-timer.sh 25
```
Pomodoro timer (default: 25 minutes).

### 10. Clipboard Manager
```bash
~/.floppies-shortcuts/clipboard-manager.sh {save|list|restore}
```
Manage clipboard history.

## Creating Shortcuts

### Using Shortcuts.app:

1. Open Shortcuts.app
2. Click "+" to create new shortcut
3. Add "Run Shell Script" action
4. Enter script path: `~/.floppies-shortcuts/script-name.sh`
5. Set "Pass input" to "as arguments" (if needed)
6. Add to Menu Bar or assign keyboard shortcut

### Example Shortcuts:

#### Quick Git Commit (⌘⇧G)
```
Run Shell Script: ~/.floppies-shortcuts/git-quick-commit.sh "$PWD"
```

#### Open Project (⌘⇧O)
```
Ask for Input: "Project path?"
Run Shell Script: ~/.floppies-shortcuts/open-project.sh "[Input]"
```

#### System Info (⌘⇧I)
```
Run Shell Script: ~/.floppies-shortcuts/system-info.sh
Show Result
```

#### Todo Add (⌘⇧T)
```
Ask for Input: "What do you need to do?"
Run Shell Script: ~/.floppies-shortcuts/todo-add.sh "[Input]"
Show Notification: "Added to todo!"
```

#### Docker Start (⌘⇧D)
```
Run Shell Script: ~/.floppies-shortcuts/docker-manager.sh start
Show Notification: "Docker started"
```

## Keyboard Shortcuts Recommendations

- ⌘⇧G - Git Quick Commit
- ⌘⇧O - Open Project
- ⌘⇧I - System Info
- ⌘⇧T - Todo Add
- ⌘⇧D - Docker Manager
- ⌘⇧S - Screenshot Organizer
- ⌘⇧A - AI Command Helper
- ⌘⇧N - Network Speed Test
- ⌘⇧B - Break Timer
- ⌘⇧C - Clipboard Manager

## Integration with Other Apps

### Alfred Integration
Create Alfred workflows that call these scripts.

### Raycast Integration
Create Raycast script commands pointing to these files.

### BetterTouchTool Integration
Assign trackpad gestures to run these scripts.

### Hammerspoon Integration
Create Hammerspoon hotkeys for these scripts.

## Tips

1. **Menu Bar Shortcuts**: Add frequently used shortcuts to menu bar
2. **Keyboard Shortcuts**: Assign global keyboard shortcuts
3. **Automation**: Combine multiple scripts in one shortcut
4. **Voice Control**: Use Siri to trigger shortcuts
5. **Context Menus**: Add shortcuts to Finder context menu

## Advanced Examples

### Morning Routine Shortcut
```
1. Run system-info.sh
2. Run todo-add.sh "Review daily goals"
3. Run docker-manager.sh start
4. Run open-project.sh "/path/to/main/project"
```

### End of Day Shortcut
```
1. Run organize-screenshots.sh
2. Run git-quick-commit.sh for all projects
3. Run docker-manager.sh stop
4. Run clipboard-manager.sh save
```

### Development Session
```
1. Run break-timer.sh 25
2. Run open-project.sh "[Selected Project]"
3. Run docker-manager.sh start
```

## Troubleshooting

### Permission Denied
```bash
chmod +x ~/.floppies-shortcuts/*.sh
```

### Script Not Found
Check that scripts are in `~/.floppies-shortcuts/`

### Shortcuts Not Running
Enable "Allow Running Scripts" in System Settings > Privacy & Security

## Resources

- [Shortcuts User Guide](https://support.apple.com/guide/shortcuts-mac)
- [Shell Scripting Primer](https://developer.apple.com/library/archive/documentation/OpenSource/Conceptual/ShellScripting/)
- [AppleScript Language Guide](https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/)
EOF

echo ""
echo "=================================================="
echo "✅ macOS Shortcuts Integration installed!"
echo "=================================================="
echo ""
echo "📁 Scripts location: $SCRIPTS_DIR"
echo "📚 Documentation: $SCRIPTS_DIR/README.md"
echo ""
echo "🎯 Next Steps:"
echo "1. Open Shortcuts.app"
echo "2. Create shortcuts using the helper scripts"
echo "3. Assign keyboard shortcuts (⌘⇧[A-Z])"
echo "4. Add to Menu Bar for quick access"
echo ""
echo "💡 Try these popular shortcuts:"
echo "   • Quick Git Commit (⌘⇧G)"
echo "   • Open Project (⌘⇧O)"
echo "   • System Info (⌘⇧I)"
echo "   • Todo Add (⌘⇧T)"
echo "   • AI Command Helper (⌘⇧A)"
echo ""
echo "📖 Full guide: cat $SCRIPTS_DIR/README.md"
echo ""
