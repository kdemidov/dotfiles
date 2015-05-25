alias ls='ls --color=auto'

# Easier navigation
alias ..='cd ..'
alias ...='cd ../..'

# TODO: Add more aliases here from my bash configs.

alias dirs='dirs -v'
# TODO: Try to use this aliases and remove if I can leave without them.
#for index ({1..9}) alias "$index"="cd +${index}"; unset index

# TODO: Move these aliases to local zsh file which is not in version control.
alias dc='cd ~/Documents'
alias dl='cd ~/Downloads'
alias dt='cd ~/Desktop'
alias pr='cd ~/Projects'

# Check the Internet connectivity by pinging some ips.
alias pgo='ping -c 1 8.8.8.8' # Google
alias pya='ping -c 1 4.2.2.2' # Yandex

# Open a file in current MacVim window instead of new one.
alias mvim='mvim --remote-tab-silent'

# Open iOS Simulator.
alias ios="open /Applications/Xcode.app/Contents/Applications/iOS\ Simulator.app"
