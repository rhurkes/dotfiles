alias la='ls -lah'
alias reload='cp ~/code/dotfiles/.bash* ~/ && source ~/.bashrc'
alias sshdo='ssh -i ~/.ssh/id_rsa_personal root@${DIGITAL_OCEAN_IP}'
alias g='git'
alias kc='kubectl'
alias vim='nvim'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'

if [ "$(uname -s)" == "Darwin" ]; then
    alias ls='ls -G'
else
    alias ls='ls --color'
fi
