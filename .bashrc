# ~/.bashrc - Petar (Debian i3 setup)

# Ne pokreći ako nije interaktivna shell
case $- in
    *i*) ;;
      *) return;;
esac

# Povijest
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Prilagodi terminal veličini prozora
shopt -s checkwinsize

# Pametniji prikaz datoteka
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Ako si u chrootu, pokaži to u promptu
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Naslov terminala (xterm, rxvt, itd.)
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Boje i aliasi
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Moji aliasi
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias gs='git status'
alias gp='git pull'
alias update='sudo apt update && sudo apt upgrade -y'
alias reboot='sudo reboot'
alias poweroff='sudo poweroff'
alias edit='nvim'
alias wifi='sudo nmtui'
alias reload='source ~/.bashrc'
alias cle='clear'

# Ako postoji ~/.bash_aliases, učitaj i njega
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Bash completion (ako je dostupan)
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
