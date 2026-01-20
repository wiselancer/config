# Claude Skills

Custom Claude Code skills will be stored here.

## What are Skills?

Skills are reusable command extensions for Claude Code that provide specialized capabilities. They can be invoked using slash commands (e.g., `/commit`, `/review-pr`).

## Available Skills

Currently using skills from the Context Engineering Kit:
- **reflexion** - Self-improvement and reflection capabilities
- **git** - Enhanced git workflows (commit, PR creation, etc.)

## Custom Skills (Coming Soon)

This directory will contain custom skills for:
- Code review automation
- Testing workflows
- Documentation generation
- Project-specific commands

## Creating Custom Skills

Documentation: https://docs.anthropic.com/claude-code/skills

Basic structure:
```yaml
name: my-skill
description: Description of what the skill does
trigger: /my-skill
handler: ./my-skill-handler.js
```

## Installation

To install a skill:
```bash
claude skills install /path/to/skill
```

To list installed skills:
```bash
claude skills list
```
