#
# Defines environment variables
#


#
# Paths
#

typeset -U path manpath

# Set the list of directories that Zsh searches for programs
path=(
  /usr/local/{bin,sbin}
  /usr/local/opt/coreutils/libexec/gnubin
  $path
)

for path_file in /etc/paths.d/*(.N); do
  path+=($(<$path_file))
done
unset path_file

# Set the list of directories that man searches for manuals
manpath=(
  /usr/local/share/man
  /usr/share/man
  /usr/local/opt/coreutils/libexec/gnuman
  $manpath
)

for path_file in /etc/manpaths.d/*(.N); do
  manpath+=($(<$path_file))
done
unset path_file

#
# Editors and pager
#

export EDITOR=vim
export VISUAL=$EDITOR
export PAGER=less

# Set the default "less" options:
# -g   Highlight only the particular string which was found by the last search command
# -i   Only search with case sensitivity if there is mixed case
# -M   Causes "less" to prompt even more verbosely than "more"
# -R   Use control characters that will color terminal output, rather than escaping them
# -S   Not fold long lines, but let them scroll off to the right
# -F   Automatically exit if the entire file can be displayed on the first screen
# -X   ignore an initialization termcap might tell it to do
# -w   Temporarily highlight the first "new" line after a forward movement of a full page
# -z-4 Scrolling window size is n lines less than the current screen size
# -x4  Use 4 space width tabs
export LESS='-g -i -M -R -S -F -X -w -z-4 -x4'

# Set "less" colors for manual pages
#
# NOTE: Command "man terminfo" can be used to get a detailed information about the modes
# NOTE: The following assignment can be used to display "source" (in terms of modes) of manual pages
#       It helps to understand to which parts of a text the modes are applied
#export LESS_TERMCAP_DEBUG=1
#
# Turn on blinking
export LESS_TERMCAP_mb=$(tput bold; tput setaf 6) # cyan
# Turn on bold (extra bright) mode
export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
# Begin standout mode
export LESS_TERMCAP_so=$(tput bold; tput setaf 7; tput setab 6) # white on cyan
# Exit standout mode
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# Begin underline mode
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
# Exit underline mode
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
# Turn off all attribute modes
export LESS_TERMCAP_me=$(tput sgr0)

# Set DEFAULT_USER to your regular username to hide the “user@hostname” info
# when you’re logged in as yourself on your local machine
#
# TODO: Uncomment the following line when prompt
#       is completely configured and tested well (other users, ssh access etc.)
#export DEFAULT_USER=`whoami`

# Prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"
