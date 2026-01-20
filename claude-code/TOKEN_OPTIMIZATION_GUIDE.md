# 💰 Claude Code: Token Optimization & Cost Savings Guide

## 📊 Understanding Your Usage

### Cost Structure (Claude Sonnet 4.5)
- **Input tokens**: $3 per million tokens
- **Output tokens**: $15 per million tokens
- **Cache read**: $0.30 per million tokens (90% savings!)
- **Cache write**: $3.75 per million tokens (25% markup)

### Your Usage Limits
Check your current usage:
```bash
/usage
```

**Important**: When you hit limits, you can't work until they reset. Monitor this closely!

---

## 🎯 Token Optimization Strategies

### 1. **Use Subagents Aggressively** ⭐⭐⭐ (HIGHEST IMPACT)

**Why Subagents Save Tokens:**
- Subagents run in isolated contexts (don't carry full conversation history)
- They only get the specific task context, not your entire session
- Perfect for discrete, well-defined tasks

**When to Use Subagents:**

✅ **ALWAYS use subagents for:**
- Code exploration ("Find all API endpoints")
- File searching ("Where is user authentication handled?")
- Documentation lookup
- Running tests
- Building projects
- Code analysis tasks
- Repetitive operations

❌ **DON'T use subagents for:**
- Ongoing conversation/discussion
- Tasks requiring full context of current work
- Interactive decision-making with you

**Example - WRONG WAY (wastes tokens):**
```
User: Find all the React components in the src directory
Assistant: *Uses Glob and Grep directly, reading files in main context*
```
Token cost: ~5K-20K tokens (loaded into main context)

**Example - RIGHT WAY (saves tokens):**
```
User: Find all the React components in the src directory
Assistant: *Launches Explore subagent*
```
Token cost: ~500-2K tokens (isolated context)

**Savings: 75-90% on exploration tasks!**

### 2. **Leverage Prompt Caching** ⭐⭐⭐

**What Gets Cached:**
- CLAUDE.md file content
- System prompts
- Large file reads
- Conversation context (first ~5 min)

**How to Maximize Cache Hits:**

✅ **DO:**
- Keep CLAUDE.md stable (changes break cache)
- Group related work in sessions
- Use consistent file paths
- Work in focused sessions (5-60 min)

❌ **DON'T:**
- Constantly edit CLAUDE.md
- Jump between unrelated projects
- Start new sessions for every small task
- Mix exploratory work with focused work

**Example:**
```bash
# Good: Focused session
Session 1: Feature development (60 min)
- Cache builds up
- 90% cache hit rate
- Cost: ~$0.05-0.10

# Bad: Scattered work
Session 1: Fix bug (5 min) → new session
Session 2: Different project (5 min) → new session
Session 3: Back to first project (5 min) → new session
- No cache hits
- Cost: ~$0.20-0.30 (3x more!)
```

### 3. **Strategic File Reading** ⭐⭐

**File Size Awareness:**
- Small file (<100 lines): Read directly - ~400 tokens
- Medium file (100-500 lines): Read if needed - ~2K tokens
- Large file (>500 lines): Use Grep first - ~5K+ tokens

**Best Practices:**

```bash
# ❌ BAD: Reading unnecessary files
"Show me all the code"
→ Reads 50 files = 100K tokens = $0.30

# ✅ GOOD: Targeted reading
"Show me the authentication logic"
→ Subagent finds files → Read 2-3 files = 5K tokens = $0.015
```

**Use Grep Before Read:**
```bash
# Find specific code first
Grep: "authentication" → Find 3 relevant files
Read: Only those 3 files

# vs reading all files and searching mentally
Read: All 50 files → Search mentally
```

### 4. **Optimize Context Window Usage** ⭐⭐

**Context Window Limits:**
- Sonnet 4.5: 200K tokens
- When 80% full: Consider starting fresh
- When 90% full: Definitely start fresh

**Why:**
- Full context window = expensive inputs
- New session = clean slate = prompt caching works
- Long contexts = slower responses

**When to Restart:**
```bash
# Good indicators to restart:
- Context >80% (watch your status line!)
- Finished a major task
- Switching to unrelated work
- Session cost >$0.50
- Response times getting slow

# Before restarting, save important context:
- Ask Claude to summarize key decisions
- Update CLAUDE.md with learnings
- Commit your work
```

### 5. **Use Haiku for Simple Tasks** ⭐

**Cost Comparison:**
- **Haiku**: $0.25/MTok input, $1.25/MTok output (12x cheaper!)
- **Sonnet**: $3/MTok input, $15/MTok output
- **Opus**: $15/MTok input, $75/MTok output

**When to Use Haiku:**
- Simple refactoring
- Running tests
- Code formatting
- Documentation generation
- File searches
- Git operations
- Straightforward bug fixes

**When to Use Sonnet (current model):**
- Complex architecture decisions
- Debugging tricky issues
- Learning/explaining complex topics
- Code review
- Multi-step planning

**How to Switch:**
```bash
# In settings.json or per-session
"model": "haiku"  # or "sonnet" or "opus"
```

---

## 🚀 Advanced Optimization Techniques

### 1. **Batch Related Work**

Instead of:
```bash
Task 1: Fix bug → new session
Task 2: Update docs → new session
Task 3: Add test → new session
```

Do:
```bash
Single session:
1. Fix bug
2. Update docs
3. Add test
→ Share context, cache hits, lower cost
```

### 2. **Use Skills for Common Patterns**

Create custom skills for repeated tasks:
```bash
# Instead of explaining each time:
"Create a PR with conventional commit format and co-author tag"

# Use skill:
/create-pr
→ Automated, consistent, fewer tokens
```

### 3. **Structured CLAUDE.md**

**Token-Efficient CLAUDE.md:**

✅ **GOOD (concise, cached):**
```markdown
# Project: E-commerce API
Stack: Node.js, PostgreSQL, Express
Patterns: REST API, MVC
Testing: Jest
Conventions: Conventional commits, ESLint
```

❌ **BAD (verbose, wastes tokens):**
```markdown
# This is our e-commerce project...
We use Node.js which is a JavaScript runtime...
PostgreSQL is our database and we chose it because...
[5 pages of explanation]
```

**The first approach gets cached and costs pennies. The second costs dollars.**

### 4. **Use Task Agents Wisely**

```javascript
// Expensive: Run in main context
Read 20 files, analyze, make decision

// Cheap: Use subagent
Task agent:
- Read 20 files (isolated context)
- Return summary (500 tokens)
- You decide in main context
```

---

## 📈 Real-World Examples

### Example 1: Feature Development

**Scenario**: Add authentication to API

**❌ EXPENSIVE WAY** ($0.80-1.20):
```
1. Read entire codebase (100K tokens)
2. Discuss architecture (10K tokens)
3. Read examples (20K tokens)
4. Implement (5K tokens)
5. Test manually (discuss each issue)
```

**✅ CHEAP WAY** ($0.10-0.20):
```
1. Explore subagent: "Find auth examples" → returns summary
2. Read 2-3 relevant files (5K tokens)
3. Focused implementation discussion (3K tokens)
4. Test subagent: "Run auth tests" → returns results
5. Iterate on failures only
```

**Savings: 75%!**

### Example 2: Debugging

**❌ EXPENSIVE** ($0.50):
```
Read all related files → discuss → read more → discuss
```

**✅ CHEAP** ($0.05):
```
1. Grep subagent: Find error location
2. Read only failing file
3. Fix
4. Test subagent: Verify fix
```

**Savings: 90%!**

### Example 3: Code Review

**❌ EXPENSIVE** ($1.00):
```
Read all changed files → discuss each → manual testing
```

**✅ CHEAP** ($0.15):
```
1. git diff → Analyze subagent reviews changes
2. Discuss only issues found
3. Test subagent runs tests
4. Quick fixes in main context
```

**Savings: 85%!**

---

## 🎓 Best Practices Summary

### Daily Habits

1. **Morning**: Start focused session, let cache build
2. **Throughout day**: Group related tasks
3. **Before breaks**: Restart if context >80%
4. **End of day**: Commit work, update CLAUDE.md

### Per-Task Checklist

- [ ] Can a subagent do this? (exploration, testing, building)
- [ ] Do I need full context? (if no → subagent)
- [ ] Can I use Haiku? (if simple → switch model)
- [ ] Can I Grep before Read? (if searching → grep first)
- [ ] Is my context >80%? (if yes → consider restart)

### Session Management

**Green Session** (<30% context, <$0.10):
- Continue working
- Cache is golden
- Very efficient

**Yellow Session** (30-80% context, $0.10-0.50):
- Watch closely
- Consider wrapping up major task
- Prepare to restart

**Red Session** (>80% context, >$0.50):
- Finish current task
- Restart session
- Save key context to CLAUDE.md

---

## 📊 Monitoring Your Usage

### Enhanced Status Line

Your new status line shows:
- **Context**: How much room you have left
- **Tokens**: Session usage
- **Cost**: Estimated cost (see updated statusline)
- **Cache**: When caching is saving you money ⚡

### Usage Commands

```bash
# Check current usage
/usage

# Watch your status line
# Green context bar = good
# Yellow context bar = moderate
# Red context bar = restart soon!
```

---

## 💡 Pro Tips

1. **"Explore First, Read Later"**
   - Use Explore subagent to understand codebase
   - Only read files you actually need

2. **"Subagent Everything Discrete"**
   - Testing? → Subagent
   - Building? → Subagent
   - Searching? → Subagent
   - Discussing? → Main context

3. **"Cache is King"**
   - Don't break your cache by constantly changing CLAUDE.md
   - Work in focused 30-60 min sessions

4. **"Context is Expensive"**
   - Watch that status line!
   - Restart before hitting 90%

5. **"Haiku for Grunt Work"**
   - Sonnet for thinking
   - Haiku for doing

---

## 🎯 Your Action Plan

### This Week

1. **Update status line** with cost tracking (see updated script)
2. **Start using Explore subagent** for all code searches
3. **Watch your status line** - restart at 80%
4. **Group related work** into focused sessions

### This Month

1. **Create custom skills** for common tasks
2. **Track your costs** - aim for <$5/day
3. **Experiment with Haiku** for simple tasks
4. **Build good CLAUDE.md** files for each project

### Success Metrics

- **Session costs**: <$0.20 average
- **Cache hit rate**: >70%
- **Context at restart**: <90%
- **Subagent usage**: >50% of exploration tasks

---

## 🔗 Additional Resources

- [Claude Pricing](https://www.anthropic.com/pricing)
- [Prompt Caching Docs](https://docs.anthropic.com/claude/docs/prompt-caching)
- [Subagent Best Practices](https://docs.anthropic.com/claude-code/agents)

---

**Remember**: The difference between $20/day and $2/day is mostly about using subagents and watching your context! 🚀
