# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Export our directory to Termite for opening new terminals
if { [[ "$TERM" =~ xterm.* ]]; }; then
    source ~/.scripts/term-title
fi

# History configuration
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

# Allow for command substitution in PS1 to have a common prompt with bash
setopt promptsubst
# Append incrementally to the history
setopt append_history
# Show an error when a globbing expansion doesn't find any match
setopt nomatch
# List on ambiguous completion and Insert first match immediately
setopt autolist menucomplete
# Don't add duplicates nor commands starting with a space to the history
setopt histignoredups histignorespace
# Use pushd when cd-ing around
setopt autopushd pushdminus pushdsilent
# Use single quotes in string without the weird escape tricks
setopt rcquotes
# Single word commands can resume an existing job
setopt autoresume
# Those options aren't wanted
unsetopt autocd beep extendedglob notify

# Use the emacs keybindings
bindkey -e
# Fix delete key not working
bindkey "\e[3~" delete-char
# Fix Ctrl+u killing from the cursor instead of the whole line
bindkey \^U backward-kill-line

# Use Ctrl+x-(Ctrl+)e to edit the current command line in VISUAL/EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Completion configuration
zstyle :compinstall filename '/home/ambroisie/.zshrc'
autoload -Uz compinit
compinit

# Import my profile on interactive shells
source ~/.profile

# Import my aliases
source ~/.aliases

# Import some useful functions
source ~/.functions

# Enable Shift-Tab to go backwards in completion list
bindkey '^[[Z' reverse-menu-complete

# Style the completion a bit
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# Show a prompt on selection
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
# Use arrow keys in completion list
zstyle ':completion:*' menu select
# Group results by category
zstyle ':completion:*' group-name ''
# Keep directories and files separated
zstyle ':completion:*' list-dirs-first true
## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'

# command for process lists, the local web server details and host completion
# on processes completion complete all user processes
zstyle ':completion:*:processes' command 'ps -au$USER'

# Completion formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

# SSH Completion
zstyle ':completion:*:scp:*' tag-order \
   files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
   files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
   users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
   hosts-domain hosts-host users hosts-ipaddr

# Hostname completion
#  1. All /etc/hosts hostnames are in autocomplete
#  2. If you have a comment in /etc/hosts like #%foobar.domain,
#     then foobar.domain will show up in autocomplete!
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts \
        | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}')

# fish-like syntax high-lighting for interactive commands (installed from AUR)
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# import my prompt
source ~/.zsh_prompt

# Use fzf for backwards search
source /usr/share/fzf/key-bindings.zsh

# Enable completions for fzf
source /usr/share/fzf/completion.zsh

# Launch tmux with a new session
if [ -z "$TMUX" ]; then
    exec tmux new-session
fi
