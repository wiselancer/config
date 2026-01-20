# MCP Servers (Model Context Protocol)

MCP server configurations will be stored here.

## What is MCP?

Model Context Protocol (MCP) is a standard for extending Claude's capabilities with external tools and data sources. MCP servers provide additional context and functionality to Claude.

## Currently Configured

Check your MCP configuration at: `~/.claude/mcp.json`

To see active MCP servers:
```bash
claude mcp list
```

## Popular MCP Servers

### Development Tools
- **@anthropic/mcp-server-filesystem** - File system operations
- **@anthropic/mcp-server-git** - Git operations
- **@anthropic/mcp-server-github** - GitHub API integration
- **@modelcontextprotocol/server-postgres** - PostgreSQL database access
- **@modelcontextprotocol/server-sqlite** - SQLite database access

### Documentation & Search
- **context7** - Library documentation search (already configured in your setup)
- **@modelcontextprotocol/server-brave-search** - Web search
- **@modelcontextprotocol/server-google-search** - Google search

### Utilities
- **@modelcontextprotocol/server-slack** - Slack integration
- **@modelcontextprotocol/server-gdrive** - Google Drive access
- **@modelcontextprotocol/server-memory** - Persistent memory/knowledge base

## Installing MCP Servers

### Via npm (recommended)
```bash
npm install -g @anthropic/mcp-server-filesystem
```

### Configure in Claude Code
Edit `~/.claude/mcp.json`:
```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-filesystem", "/path/to/allowed/directory"]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-github"],
      "env": {
        "GITHUB_TOKEN": "your-github-token"
      }
    }
  }
}
```

## Configuration Examples

Will be added here as MCP servers are configured.

## Resources

- [MCP Protocol Documentation](https://modelcontextprotocol.io)
- [Official MCP Servers](https://github.com/modelcontextprotocol/servers)
- [Anthropic MCP Guide](https://docs.anthropic.com/claude/docs/mcp)

## Security Notes

- Never commit tokens or API keys
- Use environment variables for sensitive data
- Limit filesystem access to specific directories
- Review MCP server permissions carefully
