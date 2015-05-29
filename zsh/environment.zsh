#
# Defines environment variables.
#


#
# Paths
#

typeset -U path manpath

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  /usr/local/git/bin
  /usr/local/opt/coreutils/libexec/gnubin
  $path
)

for path_file in /etc/paths.d/*(.N); do
  path+=($(<$path_file))
done
unset path_file

# Set the list of directories that man searches for manuals.
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
# -g   Highlight only the particular string which was found by the last search command.
# -i   Only search with case sensitivity if there is mixed case.
# -M   Causes "less" to prompt even more verbosely than "more".
# -R   Use control characters that will color terminal output, rather than escaping them.
# -S   Not fold long lines, but let them scroll off to the right.
# -F   Automatically exit if the entire file can be displayed on the first screen.
# -X   ignore an initialization termcap might tell it to do.
# -w   Temporarily highlight the first "new" line after a forward movement of a full page.
# -z-4 Scrolling window size is n lines less than the current screen size.
# -x4  Use 4 space width tabs.
export LESS='-g -i -M -R -S -F -X -w -z-4 -x4'

# Highlight section titles in manual pages.
export LESS_TERMCAP_md=$'\e[1;36m'

# Set DEFAULT_USER to your regular username to hide the “user@hostname” info
# when you’re logged in as yourself on your local machine.
# TODO: Uncomment the following line when prompt
#       is completely configured and tested well (other users, ssh access etc.).
#export DEFAULT_USER=`whoami`

# Prefer US English and use UTF-8.
export LANG="en_US"
export LC_ALL="en_US.UTF-8"
