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
# Editors
#

export EDITOR=vim
export VISUAL=$EDITOR
export PAGER=less

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set DEFAULT_USER to your regular username to hide the “user@hostname” info
# when you’re logged in as yourself on your local machine.
# TODO: Uncomment and use the following string instead of using the explicit name
#       when prompt is configured.
#export DEFAULT_USER=`whoami`
