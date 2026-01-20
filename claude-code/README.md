# Claude Code Configuration

This directory contains configuration files for [Claude Code](https://claude.ai/code) - Anthropic's official CLI tool.

## 📁 Directory Structure

```
claude-code/
├── statusline/          # Custom status line scripts
│   └── statusline-command.sh
├── settings/            # Claude Code settings
│   ├── settings.json.example
│   └── settings.local.json.example
├── skills/              # Custom Claude skills (future)
├── mcp-servers/         # MCP server configurations (future)
└── README.md
```

## 🎨 Status Line

### Enhanced Visual Status Line

The custom status line provides comprehensive session information at a glance:

**Features:**
- ⏰ **Time** - Current time with icon
- 🤖 **Model** - Active Claude model (Sonnet/Opus/Haiku)
- 📊 **Context Usage** - Visual progress bar showing remaining context
  - Green: <50% used (healthy)
  - Yellow: 50-80% used (moderate)
  - Red: >80% used (running low)
- 📁 **Directory** - Current working directory
- ⎇ **Git Branch** - Current branch with status indicator
  - ✓ Clean working tree
  - ● Uncommitted changes
- ⚡ **Cache Indicator** - When prompt caching is active
- ✨ **Output Style** - Current output style (if not default)
- ✎/⌘ **Vim Mode** - INSERT/NORMAL mode indicators

**Example:**
```
⏰ 14:23:45 │ 🤖 3.5S │ 📊 [██▓░░░░░░░] 77% (47K) ⚡ │ 📁 ~/dev/project │ ⎇ main ✓
```

### Installation

1. Copy the status line script:
   ```bash
   cp statusline/statusline-command.sh ~/.claude/
   chmod +x ~/.claude/statusline-command.sh
   ```

2. Update your `~/.claude/settings.json`:
   ```json
   {
     "statusLine": {
       "type": "command",
       "command": "/Users/YOUR_USERNAME/.claude/statusline-command.sh"
     }
   }
   ```

## ⚙️ Settings

### Global Settings (`~/.claude/settings.json`)

Copy the example and customize:
```bash
cp settings/settings.json.example ~/.claude/settings.json
```

**Key configurations:**
- **model** - Default model (sonnet/opus/haiku)
- **permissions** - Pre-approved tools and commands
- **statusLine** - Custom status line configuration
- **enabledPlugins** - Enabled Claude skills/plugins

### Project Settings (`.claude/settings.local.json`)

For project-specific settings:
```bash
cp settings/settings.local.json.example YOUR_PROJECT/.claude/settings.local.json
```

**Common project settings:**
- Project-specific permissions (npm, pnpm, build commands)
- Sandbox configuration
- Domain-specific WebFetch permissions

## 🔌 MCP Servers (Model Context Protocol)

> **Coming Soon** - Configuration for MCP servers

MCP servers extend Claude's capabilities. Popular servers:
- **filesystem** - File system operations
- **git** - Git repository operations
- **database** - Database queries (PostgreSQL, MySQL, etc.)
- **web-search** - Web search integration
- **context7** - Documentation search

## 🎯 Skills & Subagents

> **Coming Soon** - Custom skills and subagent configurations

### Available Skills
Check available skills with:
```bash
claude skills list
```

### Custom Skills
Create custom skills for:
- Code review workflows
- Testing automation
- Documentation generation
- CI/CD integration

## 📚 Recommended Configurations

### 1. **Git Integration**
Enable the git skill for enhanced git workflows:
```json
{
  "enabledPlugins": {
    "git@context-engineering-kit": true
  }
}
```

### 2. **Reflexion (Self-Improvement)**
Enable reflexion for better quality outputs:
```json
{
  "enabledPlugins": {
    "reflexion@context-engineering-kit": true
  }
}
```

### 3. **Sandbox Mode**
For security, enable sandbox mode:
```json
{
  "sandbox": {
    "enabled": true,
    "autoAllowBashIfSandboxed": true
  }
}
```

### 4. **Permissions**
Pre-approve common operations to reduce prompts:
```json
{
  "permissions": {
    "allow": [
      "Bash(git commit:*)",
      "Bash(git push:*)",
      "Bash(npm install:*)",
      "Bash(pnpm build:*)",
      "WebFetch(domain:api.github.com)"
    ]
  }
}
```

## 🚀 Quick Start

1. **Install Claude Code:**
   ```bash
   npm install -g @anthropic-ai/claude-code
   ```

2. **Set up configuration:**
   ```bash
   # Create config directory
   mkdir -p ~/.claude

   # Copy settings
   cp settings/settings.json.example ~/.claude/settings.json

   # Copy status line
   cp statusline/statusline-command.sh ~/.claude/
   chmod +x ~/.claude/statusline-command.sh

   # Update paths in settings.json
   sed -i '' 's/YOUR_USERNAME/'$USER'/g' ~/.claude/settings.json
   ```

3. **Start Claude Code:**
   ```bash
   claude
   ```

## 📖 Resources

- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [MCP Protocol](https://modelcontextprotocol.io)
- [Claude Skills](https://docs.anthropic.com/claude-code/skills)
- [Context Engineering Kit](https://github.com/anthropics/context-engineering-kit)

## 🔄 Updating

Keep your configuration in sync:
```bash
cd /path/to/config
git pull
cp claude-code/statusline/statusline-command.sh ~/.claude/
```

## 💡 Tips

1. **Context Management**: Watch the status line context indicator - restart sessions before hitting limits
2. **Permissions**: Start strict, add permissions as needed
3. **Project Settings**: Use `.claude/settings.local.json` for project-specific configs
4. **Skills**: Explore available skills regularly - new ones are added frequently
5. **MCP Servers**: Install only the MCP servers you need to reduce overhead

## 🐛 Troubleshooting

### Status line not updating
```bash
# Check if script is executable
chmod +x ~/.claude/statusline-command.sh

# Verify jq is installed (required for status line)
brew install jq
```

### Permission errors
Add specific permissions to your settings.json or use `dangerouslyDisableSandbox` (not recommended).

### Skills not loading
```bash
# Refresh skills
claude skills refresh
```

---

**Version:** 1.0.0
**Last Updated:** 2026-01-20
**Maintained by:** [wiselancer](https://github.com/wiselancer)
