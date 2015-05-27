#
# Prompt
#

# TODO: Check http://bit.ly/1HMxw1Z and decide what's could be useful for me and implement it here.

# Load required functions.
autoload -U promptinit && promptinit
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

# Add hook for calling vcs_info before each command.
add-zsh-hook precmd vcs_info

function +vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
    git status --porcelain | grep '??' &> /dev/null ; then
    # Show the marker if there are any untracked files in repo.
    hook_com[unstaged]='%F{red}●%f'
  fi
}

# Configure vcs_info.
zstyle ':vcs_info:*' enable git hg svn 
# NOTE: check-for-changes can be really slow.
#       You should disable it if you work with large repositories.
# TODO: Probably it makes sense to add something like implemented here: http://bit.ly/1GExafh.
#       See faster() and slower() functions.
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●%f'
zstyle ':vcs_info:*' stagedstr '%F{green}●%f'
zstyle ':vcs_info:*' formats '%F{blue}%b%f %u%c'
zstyle ':vcs_info:*' actionformats '%b%F{blue}%b%f (%F{cyan}%a%f) %u%c'
# TODO: Looks like the following style doesn't work. It needs to be checked.
zstyle ':vcs_info:svn:*' branchformat '%F{blue}%b%f|%F{cyan}%r%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

# Turns on substitutions in prompt.
setopt PROMPT_SUBST

CURRENT_BG='NONE'

# TODO: Add an explanation about prompt format and segments.

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
    # TODO: Use better colors like 166 for the user name and 136 for the host.
    prompt_segment 'NONE' yellow "%(!.%{%F{red}%}.)$USER"
    prompt_segment 'NONE' white "@"
    prompt_segment 'NONE' cyan "%m"
  fi
}

# Dir: current working directory.
prompt_dir() {
  prompt_segment 'NONE' white ": "
  # TODO: Probably it makes sense to check whether we have vcs_info or not and print longer or shorter $PWD.
  #       See http://bit.ly/1HMxw1Z (Episode III).
  prompt_segment 'NONE' green "%~"
}

prompt_vcs_info() {
  if [[ -n "$vcs_info_msg_0_" ]]; then
    prompt_segment 'NONE' white " on "
    prompt_segment 'NONE' default "${vcs_info_msg_0_}"
  fi
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
  prompt_vcs_info
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
