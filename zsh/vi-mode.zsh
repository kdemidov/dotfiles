# Based on vi-mode plugin from oh-my-zsh (https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/vi-mode).

# TODO: Suggest guys from oh-my-zsh to remove the keybindings to work with history since they are already supported:
#       http://www.cs.elte.hu/zsh-manual/zsh_14.html

# Ensures that $terminfo values are valid and updates editor information when
# the keymap changes.
function zle-keymap-select zle-line-init zle-line-finish {
  # The terminal must be in application mode when ZLE is active for $terminfo
  # values to be valid.
  if (( ${+terminfo[smkx]} )); then
    printf '%s' ${terminfo[smkx]}
  fi
  if (( ${+terminfo[rmkx]} )); then
    printf '%s' ${terminfo[rmkx]}
  fi

  zle reset-prompt
  zle -R
}

# Ensure that the prompt is redrawn when the terminal size changes.
# TODO  Check that the function works correctly (see http://bit.ly/1cpcY4a and http://bit.ly/1HUr6AL).
function TRAPWINCH() {
  zle && { zle reset-prompt; zle -R }
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
zle -N edit-command-line

bindkey -v

# Allow v to interactive editing of command line in $EDITOR
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line

# Search backwards with a pattern in the command mode.
bindkey -M vicmd '^R' history-incremental-pattern-search-backward

# Search backwards with a pattern in the insert mode.
# NOTE: It also means that Ctrl+b and Ctrl+f can be used to cycle through matches when
#       search is started from the command mode.
bindkey -M viins '^B' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward

function rprompt_vi_mode_info() {
  vi_ins_mode="%{$fg[yellow]%}[INS]%{$reset_color%}"
  vi_cmd_mode="%{$fg[cyan]%}[CMD]%{$reset_color%}"
  echo "${${KEYMAP/vicmd/${vi_cmd_mode}}/(main|viins)/${vi_ins_mode}}"
}

# Define right-hand prompt, if it wasn't defined previously.
if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
  RPROMPT='$(rprompt_vi_mode_info)'
fi
