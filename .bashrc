# ~/.bashrc: executed by bash(1) for non-login shells.                                                                                                                                                         
# If not running interactively, don't do anything                                                                                                                         
[ -z "$PS1" ] && return

# Load variables
[ -f ~/.bash_vars ] && . ~/.bash_vars

# Load secrets - do not commit these
[ -f ~/.secrets ] && . ~/.secrets

# Load work-related things - do not commit these
[ -f ~/.bash_work ] && . ~/.bash_work

# Load aliases
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# Load functions
[ -f ~/.bash_functions ] && . ~/.bash_functions

# fzf keybindings
if [ -f ~/.scripts/fzf-bindings.bash ]; then
    . ~/.scripts/fzf-bindings.bash
else
    curl 'https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.bash' -o ~/.scripts/fzf-bindings.bash && . ~/.scripts/fzf-bindings.bash
fi

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
PS1='\n$(__exit_status)  \u $(__git_ps1 "(%s)") \e[30;1m\w\e[0m\n$(__kube_ps1) $ '

# History
export HISTCONTROL=ignoredups:erasedups	# no duplicate entries
export HISTSIZE=100000	# big history
export HISTFILESIZE=100000	# big history
shopt -s histappend # append on shell exit
# Append after each command
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Dropbox - TODO still not working
if [[ "$OSTYPE" =~ ^linux ]]; then
    DROPBOX_CMD="~/.dropbox-dist/dropboxd"
    [ -f ~/.dropbox-dist/dropboxd ] && ! (pidof dropbox 1>/dev/null) && eval "${DROPBOX_CMD}" &>/dev/null &!
fi

# Golang
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin

# Rust
export PATH=$PATH:$HOME/.cargo/bin
