#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Export our directory to Termite for opening new terminals
if { [[ "$TERM" =~ xterm.* ]]; }; then
    source ~/.scripts/term-title
fi

# Make colorcoding available for everyone

Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset


# new alert text
ALERT=${BWhite}${On_Red} # Bold White on red background

# FIXME: those files should be in some folders...
# Import my aliases
source ~/.aliases

# Import some useful functions
source ~/.functions

# Import my profile on interactive shells
source ~/.profile

# Import my prompt
source ~/.bash_prompt

# Use fzf for backwards search
source /usr/share/fzf/key-bindings.bash

# Enable fzf completion
source /usr/share/fzf/completion.bash

# Launch tmux with a new session
if [ -z "$TMUX" ]; then
    exec tmux new-session
fi
