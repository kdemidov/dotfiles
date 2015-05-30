#
# History
#

# Different History files for root and standard user
if (( ! EUID )); then
  HISTFILE="$ZSH/cache/history_root"
else
  HISTFILE="$ZSH/cache/history"
fi
HISTSIZE=1024                   # big history
SAVEHIST=$HISTSIZE              # big history
# TODO: Check whether HISTIGNORE works in zsh or not.
#HISTIGNORE='&:clear:reload:ls:cd:pwd:[bf]g:exit:date:* --help:[ t\]*'
setopt APPEND_HISTORY           # append
setopt INC_APPEND_HISTORY       # add commands as they are typed, don't wait until shell exit 
setopt HIST_IGNORE_ALL_DUPS     # no duplicate
setopt HIST_REDUCE_BLANKS       # trim blanks
setopt HIST_VERIFY              # show before executing history commands
setopt BANG_HIST                # !keyword
setopt HISTNOSTORE              # Remove the history (fc -l) command from the history when invoked.
setopt HISTIGNORESPACE          # ignore space prefixed commands
setopt EXTENDED_HISTORY         # add timestamps to history
setopt SHARE_HISTORY            # share hist between sessions

#
# Various
#

setopt AUTO_REMOVE_SLASH        # self explicit
setopt CHASE_LINKS              # resolve symlinks
setopt EXTENDED_GLOB            # Use extended globbing syntax.
setopt GLOB_DOTS                # include dotfiles in globbing
setopt PRINT_EXIT_VALUE         # print return value if non-zero
setopt MULTIOS                  # Write to multiple descriptors.
setopt LISTPACKED               # Allow completion list columns to be different sizes
setopt PROMPT_SUBST             # Turns on substitutions in prompt.

unsetopt BEEP                   # no bell on error
unsetopt LIST_BEEP              # no bell on ambiguous completion
unsetopt HIST_BEEP              # no bell on error in history
unsetopt BG_NICE                # no lower prio for background jobs
unsetopt CLOBBER                # Do not overwrite existing files with > and >>.
                                # Use >! and >>! to bypass.
unsetopt HUP                    # Don't send the HUP signal to running jobs when the shell exits.
unsetopt RM_STAR_SILENT         # Ask for confirmation for `rm *' or `rm path/*'.

#
# Directories
#

setopt AUTO_CD              # Auto changes to a directory without typing cd.
setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME        # Push to home directory when no argument is given.
setopt PUSHDMINUS           # Invert meanings of +N and -N arguments to pushd.
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt AUTO_NAME_DIRS       # Auto add variable-stored paths to ~ list.
DIRSTACKSIZE=10             # Limit the number of directories to keep in history.
