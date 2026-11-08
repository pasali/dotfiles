# zsh file; shellcheck only understands sh/bash
# shellcheck disable=all
# Login shell setup: environment variables, which every child process
# inherits. Interactive-only setup (aliases, prompt, completion) is in zshrc.

# tmux panes are login shells and re-run this file; keep PATH entries unique.
typeset -U path PATH

# Homebrew's default prefixes: Apple Silicon first, then Intel.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# After brew so personal PATH entries take precedence.
[[ -r ~/.exports ]] && source ~/.exports

# Machine-local secrets (untracked, chmod 600).
[[ -r ~/.zsh_private ]] && source ~/.zsh_private

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
