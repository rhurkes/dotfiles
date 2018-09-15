# ~/.bashrc: executed by bash(1) for non-login shells.                                                                                                                                                         
# If not running interactively, don't do anything                                                                                                                         
[ -z "$PS1" ] && return

# Load variables
[ -f ~/.bash_vars ] && . ~/.bash_vars

# Load aliases
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# Load functions
[ -f ~/.bash_functions ] && . ~/.bash_functions

# fzf keybindings
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash

# git completion
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
else
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash && . ~/.git-completion.bash
fi

# git prompt
GIT_PROMPT=1
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
if [ -f ~/.scripts/git-prompt.sh ]; then
    source ~/.scripts/git-prompt.sh
else
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.scripts/git-prompt.sh && source ~/.scripts/git-prompt.sh
fi
PS1='\n$(smiley) \u@\h $(__git_ps1 "(%s)") \e[30;1m\w\e[0m\n\$ '

# History
export HISTCONTROL=ignoredups:erasedups	# no duplicate entries
export HISTSIZE=100000	# big history
export HISTFILESIZE=100000	# big history
shopt -s histappend # append on shell exit
# Append after each command
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Dropbox
[ -f ~/.dropbox-dist/dropboxd ] && ! (pidof dropbox 1>/dev/null) && (~/.dropbox-dist/dropboxd &)&

# Golang
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin

# Rust
export PATH=$PATH:$HOME/.cargo/bin

