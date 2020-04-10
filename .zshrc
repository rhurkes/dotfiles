# VARS
if [[ -z $commands[kubectl] ]]; then export HAS_K8S=false; else export HAS_K8S=true; fi

# PATH
export GOPATH=$HOME/go  # golang
PATH=$PATH:$GOPATH/bin  # golang
PATH=$PATH:$HOME/.cargo/bin # rust
PATH=$PATH:/usr/local/opt/postgresql@9.6/bin    # postgres

# ALIASES
alias k=kubectl
alias ope=fuck

# register auto-complete functionality
autoload -Uz compinit
compinit

# FZF SETUP
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# NAVI SETUP
source <(navi widget zsh)

# KUBERNETES SETUP
if [[ $HAS_K8S == true ]]; then
    # set the icon
    export K8S_ICON=$(echo -e '\u2388')
    # enable kubectl autocomplete
    source <(kubectl completion zsh)
    complete -F __start_kubectl k
fi

# THEFUCK SETUP
eval $(thefuck --alias)

# USER FUNCTIONS
# killport - kills a process using specified port number
killport () {
    if [[ -z $1 ]]
    then
        echo "usage: killport <port number>"
        return
    fi

    pid=$(lsof -i:$1 -sTCP:LISTEN -t)

    if [[ -z $pid ]]
    then
        echo "no process found running on $1"
    else
        echo "killing process $pid"
        kill -TERM $pid || kill -KILL $pid
    fi
}

# SCRIPT FUNCTIONS
__k8s_context() {
    CONTEXT=$(cat ~/.kube/config | grep "current-context:" | sed "s/current-context: //")
    if [[ -n "$CONTEXT" ]]; then
        echo " %F{cyan}[%F{white}${K8S_ICON} ${CONTEXT}%F{cyan}]%F"
    fi
}

__git_branch() {
  BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    if [[ -n "$BRANCH" ]]; then
        echo " %F{cyan}[%F{white}${BRANCH}%F{cyan}]%F"
    fi
}

# TARGET THINGS
[[ -f ~/.targetrc ]] && source ~/.targetrc

# PROMPT
export PROMPT='
%F{cyan}[%F{white}%3~%F{cyan}]%F$(__git_branch)$(__k8s_context)
%f%(?.%F{green}√.%F{red}?%?)%f %# '
# Allow prompt to expand commands, ie. update after every command
# Requires that the above prompt is single quoted.
setopt promptsubst

# HISTORY
# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
