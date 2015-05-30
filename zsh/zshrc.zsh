# TODO: Add a header here like .vimrc has.

ZSH="$HOME/.dotfiles/zsh"

typeset -ga sources

sources+="$ZSH/environment.zsh"
sources+="$ZSH/options.zsh"
sources+="$ZSH/vi-mode.zsh"
sources+="$ZSH/prompt.zsh"
sources+="$ZSH/aliases.zsh"
sources+="$ZSH/functions.zsh"
sources+="$ZSH/completion.zsh"
sources+="$ZSH/third-party/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Try to include all sources.
for file (`echo $sources`); do
  if [[ -r $file ]]; then
    source $file
  fi
done

# Include local aliases, adoptions etc. 
for file ($ZSH/local/*.zsh); do
  if [[ -r $file ]]; then
    source $file
  fi
done

autoload -U colors zsh-mime-setup zmv
colors
zsh-mime-setup  # run everything as if it's an executable

# Auto quote pasted URLs.
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

DIRCOLORS_FILE="$ZSH/third-party/dircolors-solarized/dircolors.256dark"
if [[ -f $DIRCOLORS_FILE ]]; then
  if type dircolors > /dev/null 2>&1; then
    eval $(dircolors $DIRCOLORS_FILE)
  fi
fi

# Set the terminal title to "username@hostname: directory".
case $TERM in
  xterm*)
    precmd () {
      print -Pn "\e]0;%n@%m: %~\a"
    }
    ;;
esac
