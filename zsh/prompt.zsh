#
# Prompt
#

# TODO: Add vcs_info to the prompt.

autoload -U promptinit
promptinit

# Turns on substitutions in prompt.
setopt PROMPT_SUBST

CURRENT_BG='NONE'

# Begin a segment.
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  # TODO: Make background an optional parameter.
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n "%{$bg%F{$CURRENT_BG}%}%{$fg%}"
  else
    echo -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments.
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n "%{%k%F{$CURRENT_BG}%}"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

# Context: user@hostname (who am I and where am I).
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment 'NONE' yellow "%(!.%{%F{red}%}.)$USER"
    prompt_segment 'NONE' white " at "
    prompt_segment 'NONE' cyan "%m"
    prompt_segment 'NONE' white " in "
  fi
}

# Dir: current working directory.
prompt_dir() {
  prompt_segment 'NONE' green "%~"
}

prompt_newline() {
  echo ''
}

# Command line.
prompt_command_line() {
  prompt_segment 'NONE' white "$"
}

# Main prompt
build_prompt() {
  prompt_context
  prompt_dir
  prompt_newline
  prompt_command_line
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '

#
# Right-hand prompt
#
# NOTE: Right-hand prompt is set in vi-mode.zsh file and it displays the current vi mode (CMD/INS).

#
# Prompt for spelling correction
#

SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
