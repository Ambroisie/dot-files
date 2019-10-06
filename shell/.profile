# Add our scripts to the path
export PATH="$HOME/.scripts:$PATH"

# Export our favorite editor
export EDITOR=vim
export VISUAL=$EDITOR # Also use it when asking for a GUI
# Export our terminal for i3-sensible-terminal
export TERMINAL=termite

# Use my own ranger config file with all mappings defined
export RANGER_LOAD_DEFAULT_RC=FALSE

# Color ls output depending on filetype with dircolors
[ -e "/etc/DIR_COLORS" ] && DIR_COLORS="/etc/DIR_COLORS"
[ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
[ -e "$DIR_COLORS" ] || DIR_COLORS=""
eval "`dircolors -b $DIR_COLORS`"

# Use less as my default pager
export PAGER=less
# Allow for colorful man pages, clear the screen on exit
export LESS='-R -+X'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Use lesspipe as a file preprocessor (unlike  bat, can somewhat read pdf)
{ [ -x /usr/bin/lesspipe.sh ] && eval "$(lesspipe.sh)" } ||
{ [ -x /usr/bin/lesspipe ] && eval "$(lesspipe)" } # Quoting seems necessary

# Use my preferred pager settings for bat
export BAT_PAGER="$PAGER $LESS"

# Rust installation
export PATH="$HOME/.cargo/bin:$PATH"

# Use keychain to handle ssh-agent
eval $(keychain --eval id_rsa --quiet)
