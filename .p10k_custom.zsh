function prompt_poetry_env {
    local env_path
    env_path=$(poetry env info --path 2>/dev/null)
    [[ -n "$env_path" ]] && p10k segment -i '🐍' -t "${env_path:t}"
  }
  # Add this segment definition
  POWERLEVEL9K_POETRY_ENV_FOREGROUND=228
  POWERLEVEL9K_POETRY_ENV_VISUAL_IDENTIFIER_EXPANSION='🐍 '
  
  # Left prompt segments.
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    context                   # user@host
    dir                       # current directory
    vcs                       # git status
    command_execution_time    # previous command duration
    virtualenv                # python virtual environment
    prompt_char               # prompt symbol
  )

  # Right prompt segments.
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    command_execution_time  # previous command duration
    poetry_env                # custom poetry segment
    #virtualenv              # python virtual environment
    #context                 # user@host
    time                    # current time
  )
