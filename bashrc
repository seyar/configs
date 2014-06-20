# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

alias l='ls -la'

alias mb='make -B'
alias mcl='make clean'
alias mli='make lego.import'
alias mdg='make debug'
alias mdv='make dev'
alias mr='make rebuild'

alias cdh='cd html'
alias cdw='cd www && l'
alias v='cd ..'
alias vv='cd ../..'
alias vvv='cd ../../..'
alias vvvv='cd ../../../..'
alias ve='vi .'

alias tmu='tmux attach || tmux new '
alias tmuxkill='tmux kill-server '

alias bcb='bem create block'
alias em='./node_modules/.bin/enb make'
alias ei18n='./node_modules/.bin/enb i18n.get'
alias св='cd'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export LC_ALL=ru_RU.UTF-8

#alias algol='ssh algol.maps.yandex.ru'
#alias vega='ssh vega.maps.yandex.ru'

alias dch='dch --distributor debian --distribution unstable'
export EMAIL="Seyar Chapuh <seyar@yandex-team.ru>"

alias gs='git status -s'
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias go='git checkout '

alias gsl='git status | less'
alias gl='git log'

alias ggom='git pull origin master'
alias gsom='git push origin master'
alias ggod='git pull origin dev'
alias gsod='git push origin dev'

alias gom='git checkout master'
alias grh='git reset --hard'
alias gcl='git clean -f -d'
alias gcp='git cherry-pick'
alias gfo='git fetch origin'
alias grm='git rm -r'
alias gms='git merge --squash'
alias gabp='git add blocks/ pages/'
alias grsh='git reset --soft HEAD^'
alias gh='git hist'
alias gd='git diff'
alias пы='git status -s'
alias пв='git diff'
alias пр='git hist'

source ~/.bash/.git-completion.sh
complete -o default -o nospace -F _git_checkout go
complete -o default -o nospace -F _git_branch gb

 function __set_prompt
 {
     # Configure Colors:
     WHITE='\033[1;37m'
     LIGHTGRAY='033[0;37m'
     GRAY='\033[1;30m'
     BLACK='\033[0;30m'
     RED='\033[0;31m'
     LIGHTRED='\033[1;31m'
     GREEN='\033[0;32m'
     LIGHTGREEN='\033[1;32m'
     BROWN='\033[0;33m'
     YELLOW='\033[1;33m'
     BLUE='\033[0;34m'
     LIGHTBLUE='\033[1;34m'
     PURPLE='\033[0;35m'
     PINK='\033[1;35m'
     CYAN='\033[0;36m'
     LIGHTCYAN='\033[1;36m'
     DEFAULT='\033[0m'

     export PS1="\[${RED}\]\h\[${LIGHTBLUE}\]"' $(__git_ps1 "(%s) ")'"\[${GREEN}\]\w \[${DEFAULT}\] "
 }

 __set_prompt

export NODE_PATH="/usr/local/homebrew/share/npm/bin"
export NODE_PATH="/usr/local/lib/node_modules"

alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin

alias port="sudo port"
alias portup="port -v selfupdate && port upgrade outdated"

export PATH=/Users/seyar/.gem/ruby/1.8/bin:$PATH
export PATH=/Developer/usr/bin:/opt/local/bin:$PATH
