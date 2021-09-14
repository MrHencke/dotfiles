#Displays the prosseses on top of the terminal
ps -u $USER -o %cpu,%mem,comm | sort -d -r -k2 | head

# Prompt
autoload -U colors && colors		# Add colors
PS1="%{$fg[red]%}%1~ "			# Add path
[ ! -z "$SSH_TTY" ] && PS1="%m $PS1"	# Add indicator if in ssh session
[ -n "$NNNLVL" ] && PS1="N$NNNLVL $PS1"	# NNN shell nested spawn level

stty stop undef		# Disable ctrl-s to freeze terminal.
setopt autocd		# Automatically cd into typed directory.
setopt interactive_comments


[ -f "$XDG_CONFIG_HOME/shell/aliasrc" ] && source "$XDG_CONFIG_HOME/shell/aliasrc"
[ -f "$XDG_CONFIG_HOME/shell/shortcutrc" ] && source "$XDG_CONFIG_HOME/shell/shortcutrc"

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$XDG_CACHE_HOME/zsh/history
mkdir -p $XDG_CACHE_HOME/zsh

# Do not match urls with local files
unsetopt nomatch

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
_comp_options+=(globdots)		# Include hidden files.


# Load zsh-autosuggestions.
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
