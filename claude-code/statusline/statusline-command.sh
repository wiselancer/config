#!/bin/bash
# Claude Code statusline with cost tracking
# Shows: time | model | context | cost | directory | git | vim mode

# Read JSON input
input=$(cat)

# Extract data from JSON
dir=$(printf '%s' "$input" | jq -r '.workspace.current_dir // empty' 2>/dev/null)
: "${dir:=$PWD}"
dir="${dir/#$HOME/~}"

model_name=$(printf '%s' "$input" | jq -r '.model.display_name // empty' 2>/dev/null)
output_style=$(printf '%s' "$input" | jq -r '.output_style.name // empty' 2>/dev/null)
vim_mode=$(printf '%s' "$input" | jq -r '.vim.mode // empty' 2>/dev/null)

# Context window information
used_pct=$(printf '%s' "$input" | jq -r '.context_window.used_percentage // empty' 2>/dev/null)
remaining_pct=$(printf '%s' "$input" | jq -r '.context_window.remaining_percentage // empty' 2>/dev/null)
total_input=$(printf '%s' "$input" | jq -r '.context_window.total_input_tokens // empty' 2>/dev/null)
total_output=$(printf '%s' "$input" | jq -r '.context_window.total_output_tokens // empty' 2>/dev/null)
cache_read=$(printf '%s' "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0' 2>/dev/null)
cache_creation=$(printf '%s' "$input" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0' 2>/dev/null)

# Get current time
time=$(date +%H:%M:%S)

# Get git info (fast, no locks)
real_dir="${dir/#\~/$HOME}"
git_info=""
git_branch=$(GIT_OPTIONAL_LOCKS=0 git -C "$real_dir" branch --show-current 2>/dev/null) || true
if [[ -z "$git_branch" ]]; then
    git_branch=$(GIT_OPTIONAL_LOCKS=0 git -C "$real_dir" rev-parse --short HEAD 2>/dev/null) || true
    [[ -n "$git_branch" ]] && git_branch="@$git_branch"
fi

# Check for uncommitted changes
if [[ -n "$git_branch" ]]; then
    if ! GIT_OPTIONAL_LOCKS=0 git -C "$real_dir" diff --quiet 2>/dev/null || \
       ! GIT_OPTIONAL_LOCKS=0 git -C "$real_dir" diff --cached --quiet 2>/dev/null; then
        git_info="$git_branch"
        git_status="●"
    else
        git_info="$git_branch"
        git_status="✓"
    fi
fi

# Calculate estimated cost (Sonnet 4.5 pricing: $3/MTok input, $15/MTok output)
# Cache read: $0.30/MTok, Cache write: $3.75/MTok
if [[ -n "$total_input" ]] && [[ -n "$total_output" ]]; then
    # Adjust input tokens for cache
    regular_input=$((total_input - cache_read - cache_creation))
    [[ $regular_input -lt 0 ]] && regular_input=0

    # Calculate costs (in cents for readability)
    input_cost=$(awk "BEGIN {printf \"%.2f\", ($regular_input / 1000000) * 3}")
    output_cost=$(awk "BEGIN {printf \"%.2f\", ($total_output / 1000000) * 15}")
    cache_read_cost=$(awk "BEGIN {printf \"%.2f\", ($cache_read / 1000000) * 0.30}")
    cache_creation_cost=$(awk "BEGIN {printf \"%.2f\", ($cache_creation / 1000000) * 3.75}")

    total_cost=$(awk "BEGIN {printf \"%.2f\", $input_cost + $output_cost + $cache_read_cost + $cache_creation_cost}")

    # Calculate cache savings
    cache_savings=0
    if [[ $cache_read -gt 0 ]]; then
        # Savings = (regular price - cache price) * tokens
        cache_savings=$(awk "BEGIN {printf \"%.2f\", ($cache_read / 1000000) * (3 - 0.30)}")
    fi
fi

# Color codes
DIM='\033[2m'
BOLD='\033[1m'
RESET='\033[0m'
GRAY='\033[90m'
GREEN='\033[92m'
YELLOW='\033[93m'
RED='\033[91m'
BLUE='\033[94m'
CYAN='\033[96m'
MAGENTA='\033[95m'
WHITE='\033[97m'

# Separator
SEP="${GRAY}│${RESET}"

# Time
printf "${GREEN}⏰ ${BOLD}%s${RESET}" "$time"

# Model name
if [[ -n "$model_name" ]]; then
    short_model=$(printf '%s' "$model_name" | sed -E 's/Claude ([0-9.]+) (Sonnet|Opus|Haiku).*/\1\2/' | sed 's/Sonnet/S/;s/Opus/O/;s/Haiku/H/')
    printf " ${SEP} ${CYAN}🤖 ${BOLD}%s${RESET}" "$short_model"
fi

# Context usage with visual progress bar
if [[ -n "$used_pct" ]] && [[ "$used_pct" != "null" ]]; then
    used_int=${used_pct%.*}
    remaining_int=${remaining_pct%.*}

    # Color based on usage
    if (( used_int < 50 )); then
        ctx_color="$GREEN"
        bar_icon="█"
    elif (( used_int < 80 )); then
        ctx_color="$YELLOW"
        bar_icon="▓"
    else
        ctx_color="$RED"
        bar_icon="▒"
    fi

    # Create mini progress bar (10 chars wide)
    bar_filled=$(( used_int / 10 ))
    bar_empty=$(( 10 - bar_filled ))
    bar=""
    for ((i=0; i<bar_filled; i++)); do bar+="$bar_icon"; done
    for ((i=0; i<bar_empty; i++)); do bar+="░"; done

    printf " ${SEP} ${ctx_color}📊 [%s]${RESET} ${ctx_color}${BOLD}%d%%${RESET}" "$bar" "$remaining_int"

    # Show total tokens
    if [[ -n "$total_input" ]] && [[ -n "$total_output" ]]; then
        total_tokens=$((total_input + total_output))
        if (( total_tokens >= 1000000 )); then
            token_display="$(awk "BEGIN {printf \"%.1f\", $total_tokens/1000000}")M"
        elif (( total_tokens >= 1000 )); then
            token_display="$(awk "BEGIN {printf \"%.0f\", $total_tokens/1000}")K"
        else
            token_display="$total_tokens"
        fi
        printf " ${DIM}(%s)${RESET}" "$token_display"
    fi

    # Cache indicator with savings
    if [[ -n "$cache_read" ]] && [[ "$cache_read" != "0" ]] && [[ "$cache_read" != "null" ]]; then
        if (( $(awk "BEGIN {print ($cache_savings > 0) ? 1 : 0}") )); then
            printf " ${YELLOW}⚡${GREEN}-\$%.2f${RESET}" "$cache_savings"
        else
            printf " ${YELLOW}⚡${RESET}"
        fi
    fi
fi

# Session cost (if calculated)
if [[ -n "$total_cost" ]] && (( $(awk "BEGIN {print ($total_cost > 0) ? 1 : 0}") )); then
    # Color code based on cost
    if (( $(awk "BEGIN {print ($total_cost < 0.10) ? 1 : 0}") )); then
        cost_color="$GREEN"
    elif (( $(awk "BEGIN {print ($total_cost < 0.50) ? 1 : 0}") )); then
        cost_color="$YELLOW"
    else
        cost_color="$RED"
    fi
    printf " ${SEP} ${cost_color}💰 \$${BOLD}%s${RESET}" "$total_cost"
fi

# Directory
printf " ${SEP} ${BLUE}📁 ${BOLD}%s${RESET}" "$dir"

# Git branch with status
if [[ -n "$git_info" ]]; then
    if [[ "$git_status" == "●" ]]; then
        printf " ${SEP} ${MAGENTA}⎇  ${BOLD}%s${RESET} ${YELLOW}%s${RESET}" "$git_info" "$git_status"
    else
        printf " ${SEP} ${MAGENTA}⎇  ${BOLD}%s${RESET} ${GREEN}%s${RESET}" "$git_info" "$git_status"
    fi
fi

# Output style (if not default)
if [[ -n "$output_style" ]] && [[ "$output_style" != "default" ]]; then
    printf " ${SEP} ${WHITE}✨ %s${RESET}" "$output_style"
fi

# Vim mode (if enabled)
if [[ -n "$vim_mode" ]]; then
    if [[ "$vim_mode" == "INSERT" ]]; then
        printf " ${SEP} ${GREEN}${BOLD}✎ INSERT${RESET}"
    else
        printf " ${SEP} ${YELLOW}${BOLD}⌘ NORMAL${RESET}"
    fi
fi

exit 0
