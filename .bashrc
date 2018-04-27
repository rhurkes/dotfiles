# ~/.bashrc: executed by bash(1) for non-login shells.                                                                                                                                                         
# If not running interactively, don't do anything                                                                                                                         
[ -z "$PS1" ] && return

# Load variables
if [ -f ~/.bash_vars ]; then
    . ~/.bash_vars
fi

# Load aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Load functions
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# git completion
# curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# git prompt
# curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/scripts/git-prompt.sh
GIT_PROMPT=0
if [ -f ~/scripts/git-prompt.sh ]; then
    source ~/scripts/git-prompt.sh
    GIT_PROMPT=1
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWUPSTREAM="auto"
fi

if [ GIT_PROMPT = 0 ]; then
    PS1="\n\$(smiley) \u@\h \e[30;1m\w\e[0m\n\$ "
else
    PS1='\n$(smiley) \u@\h $(__git_ps1 "(%s)") \e[30;1m\w\e[0m\n\$ '
fi
