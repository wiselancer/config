# 🚀 Claude Code Quick Reference - Token Saving Edition

## ⚡ Golden Rules

1. **Subagent for exploration** - Use Task tool with Explore agent
2. **Restart at 80%** - Watch your status line!
3. **Cache is gold** - Focused sessions, stable CLAUDE.md
4. **Grep before Read** - Find first, then read
5. **Haiku for simple** - 12x cheaper for straightforward tasks

---

## 🎯 Quick Decision Tree

```
Need to explore code?
└─> Use Explore subagent (NOT Grep/Read directly)
    Savings: 75-90%

Need to run tests/build?
└─> Use Task subagent
    Savings: 80-95%

Context > 80%?
└─> Restart session
    Saves: Future expensive inputs

Simple task? (refactor, format, docs)
└─> Switch to Haiku
    Savings: 90%+

Searching for code?
└─> Grep first → Read only matches
    Savings: 60-80%
```

---

## 📋 Common Tasks - Optimized

### 🔍 Exploring Codebase

```bash
# ❌ DON'T (expensive):
User: "Show me how authentication works"
Claude: *reads 20 files directly* → 40K tokens → $0.12

# ✅ DO (cheap):
User: "Show me how authentication works"
Claude: *uses Explore subagent* → 2K tokens → $0.006
Savings: 95%!
```

### 🧪 Running Tests

```bash
# ❌ DON'T:
User: "Run tests and tell me results"
Claude: *runs in main context, discusses each failure*
→ 15K tokens → $0.045

# ✅ DO:
User: "Run tests"
Claude: *Task subagent runs tests* → returns summary
→ 1K tokens → $0.003
Savings: 93%!
```

### 🐛 Debugging

```bash
# ❌ DON'T:
Read entire codebase → discuss → read more
→ 50K tokens → $0.15

# ✅ DO:
Grep error location → Read only that file → Fix
→ 3K tokens → $0.009
Savings: 94%!
```

### 📝 Documentation

```bash
# ❌ DON'T (Sonnet):
Generate docs → 10K output tokens → $0.15

# ✅ DO (Haiku):
Generate docs → 10K output tokens → $0.0125
Savings: 92%!
```

---

## 🎨 Status Line Guide

### What You See

```
⏰ 14:23:45 │ 🤖 3.5S │ 📊 [██▓░░░░░░░] 77% (47K) ⚡-$0.12 │ 💰 $0.28 │ 📁 ~/dev/project │ ⎇ main ✓
```

### What It Means

- `77%` - Context remaining (GREEN = good, YELLOW = watch, RED = restart!)
- `(47K)` - Tokens used this session
- `⚡-$0.12` - Cache savings (you saved $0.12!)
- `💰 $0.28` - Session cost so far

### Action Based on Colors

| Color | Context | Cost | Action |
|-------|---------|------|--------|
| 🟢 GREEN | <50% | <$0.10 | Keep working! |
| 🟡 YELLOW | 50-80% | $0.10-0.50 | Watch closely |
| 🔴 RED | >80% | >$0.50 | Restart soon! |

---

## 💰 Cost Estimation

### Quick Math

| Task | Tokens | Cost (Sonnet) | Cost (Haiku) |
|------|--------|---------------|--------------|
| Simple question | 1K | $0.003 | $0.0003 |
| Code exploration | 10K | $0.03 | $0.003 |
| Feature development | 50K | $0.15 | $0.015 |
| Major refactor | 200K | $0.60 | $0.06 |

**Cache hits reduce input by 90%!**

### Daily Budget Examples

**Conservative ($2/day):**
- ~70K tokens (10-15 focused sessions with subagents)
- Use Haiku for 50% of tasks
- Aggressive subagent use

**Moderate ($5/day):**
- ~170K tokens (20-30 sessions)
- Sonnet for most work
- Regular subagent use

**Heavy ($10/day):**
- ~340K tokens (40-60 sessions)
- All Sonnet
- Some subagent use

---

## 🛠️ Common Commands

```bash
# Check usage
/usage

# Switch model (in settings)
"model": "haiku"    # Cheap
"model": "sonnet"   # Balanced (default)
"model": "opus"     # Expensive, smartest

# Launch subagent (Claude does this automatically when appropriate)
# YOU don't need to do anything - just ask naturally:
"Find all API endpoints" → Claude uses Explore subagent
"Run the tests" → Claude uses Task subagent

# Restart session when needed
# Just close and reopen Claude
```

---

## 📊 Session Strategies

### Short Task (<5 min)

```
1. Quick question/fix
2. Use existing context
3. Don't worry about optimization
Cost: $0.01-0.05
```

### Medium Session (30-60 min)

```
1. Let cache build (first 5 min)
2. Group related tasks
3. Use subagents for exploration/testing
4. Restart if hitting 80%
Cost: $0.10-0.30
```

### Long Session (2+ hours)

```
1. Plan to restart 2-3 times
2. Update CLAUDE.md between sessions
3. Heavy subagent use
4. Consider Haiku for grunt work
Cost: $0.50-1.00
```

---

## ⚠️ Common Mistakes

### 1. Reading Too Much

```bash
# ❌ Bad
"Show me all the code in src/"
→ Reads 50 files → $0.30

# ✅ Good
"Use Explore to find authentication code"
→ Subagent explores → $0.02
```

### 2. Not Using Subagents

```bash
# ❌ Bad
Manually Grep, Read, analyze in main context
→ $0.20

# ✅ Good
Explore subagent does it all
→ $0.02
```

### 3. Ignoring Context Warnings

```bash
# ❌ Bad
Context at 95% → keep working → slow & expensive
→ $0.80 session

# ✅ Good
Context at 80% → restart → fast & cached
→ $0.15 session
```

### 4. Breaking Cache

```bash
# ❌ Bad
Edit CLAUDE.md every 10 minutes
→ Cache breaks constantly → 0% hit rate

# ✅ Good
Stable CLAUDE.md → 70%+ cache hit rate
→ 90% cost reduction on cached tokens
```

---

## 🎯 Weekly Checklist

### Monday
- [ ] Review last week's usage
- [ ] Set budget goal
- [ ] Clean up CLAUDE.md files

### Daily
- [ ] Start focused sessions
- [ ] Use subagents for exploration
- [ ] Restart at 80% context
- [ ] Track session costs

### Friday
- [ ] Review week's costs
- [ ] Identify wasteful patterns
- [ ] Adjust strategies

---

## 💡 Power User Tips

1. **Alias Common Patterns**
   ```bash
   # Add to .zshrc
   alias ce="claude explore"  # Quick exploration
   alias ct="claude test"     # Quick testing
   ```

2. **Keyboard Shortcuts**
   - Learn Claude Code keyboard shortcuts
   - Faster = fewer tokens explaining

3. **Template Responses**
   - "Use standard commit format" (saves explanation tokens)
   - "Follow project conventions" (Claude reads CLAUDE.md)

4. **Batch Work**
   - Fix 3 bugs in one session (not 3 sessions)
   - Review 5 PRs in one session

5. **CLAUDE.md Mastery**
   - Keep it concise (<500 lines)
   - Update weekly, not hourly
   - Let it get cached!

---

## 📈 Success Metrics

Track these weekly:

- **Average session cost**: Target <$0.20
- **Cache hit rate**: Target >60%
- **Subagent usage**: Target >50% of exploration
- **Context at restart**: Target <85%
- **Weekly budget**: Target <$25

---

## 🆘 Emergency Cost Reduction

If you're burning through budget:

1. **Immediate**: Switch to Haiku for everything
2. **Today**: Only use subagents (no direct file reading)
3. **This week**: Restart every 30 min
4. **Going forward**: Review this guide daily

---

## 🎓 Learning Path

1. **Week 1**: Master subagents
2. **Week 2**: Optimize cache usage
3. **Week 3**: Try Haiku for simple tasks
4. **Week 4**: Create custom skills
5. **Month 2**: Advanced optimization

---

Remember: **Subagents + Cache + Watch Status = 80% cost savings!** 🚀
