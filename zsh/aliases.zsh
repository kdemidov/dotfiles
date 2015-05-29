# Reload zsh config.
alias reload="source $HOME/.zshrc"

# Enable aliases to be sudo’ed.
alias sudo='sudo '

alias py='python'
alias v='vim'

# Shortcuts.
# TODO: Probably it make sense to move these aliases to local zsh file which is not in version control.
alias dc='cd ~/Documents'
alias dl='cd ~/Downloads'
alias dt='cd ~/Desktop'
alias pr='cd ~/Projects'

# Print the directory stack with one entry per line, prefixing each entry with its index in the stack.
alias dirs='dirs -v'

## Always use color output for "ls".
alias ls='ls --color=auto'

# List all files colorized in long format.
alias l='ls -lF'

# List all files colorized in long format, including dot files.
alias la='l -a'

# List only directories.
alias lsd='l | grep --color=never "^d"'

# Convert permissions to octal.
alias lsoct='l | sed -e "s/--x/1/g" -e "s/-w-/2/g" -e "s/-wx/3/g" -e "s/r--/4/g" -e "s/r-x/5/g" -e "s/rw-/6/g" -e "s/rwx/7/g" -e "s/---/0/g"';

# Check the Internet connectivity by pinging some ips.
alias pgo='ping -c 1 8.8.8.8' # Google
alias pya='ping -c 1 4.2.2.2' # Yandex

# Show size of disc in MB/GB instead of 'blocks'.
alias hdd='df -h'

# Memory output in MB.
alias free='free -m'

# Prevents accidentally clobbering files.
alias rm='rm -i'
alias cp='cp -vi'
alias mv='mv -i'
alias mkdir='mkdir -p'

# Grant the owner of a file execution permissions.
alias chux='chmod u+x'

# Get date and time in YYYY-MM-DD HH:MM:SS format (MySQL's DATETIME format).
alias now='date "+%Y-%m-%d %T"'

# Output appended data as the file grows.
alias tf='tail -f'

# Output the last 100 lines.
alias t100='tail -n 100'

# Print the newline counts for each file.
alias wl='wc -l'

# Copy output of last command to clipboard.
alias cpylc="fc -e -|pbcopy"

# Run 'top' with useful sorting.
alias topcpu='top -o cpu'
alias topmem='top -o rsize'

# Find processes.
alias psx="ps auxw | grep $1"

# Copy the working directory path.
alias cpwd='pwd|tr -d "\n"|pbcopy'

# List TODO/FIX lines from the current project.
alias todos="ack -n --nogroup '(TODO|FIX(ME)?):'"

# Show top 10 biggest files or directories in current directory.
alias biggest="du -sh * | sort -rn | head"

# Found in Lifehacker Comments.
# http://lifehacker.com/software/how-to/turbocharge-your-terminal-274317.php#c1782742
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

# Gzip-enabled `curl`.
alias gurl='curl --compressed'

# IP addresses.
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip='ipconfig getifaddr en1'

# URL-encode strings.
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Recursively delete ".DS_Store" files.
alias dsclean='find . -type f -name "*.DS_Store" -ls -delete'

# Lock the screen (when going AFK).
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Hide/show all desktop icons (useful when presenting).
alias hidedesktop='defaults write com.apple.finder CreateDesktop -bool false && killall Finder'
alias showdesktop='defaults write com.apple.finder CreateDesktop -bool true && killall Finder'

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash='sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl'

# Open a file in current MacVim window instead of new one.
alias mvim='mvim --remote-tab-silent'

# Open iOS Simulator.
alias ios="open /Applications/Xcode.app/Contents/Applications/iOS\ Simulator.app"
