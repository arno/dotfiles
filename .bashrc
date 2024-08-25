# /etc/bash/bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# Source system bashrc
[[ -f /etc/bashrc ]] && . /etc/bashrc
[[ -f /etc/bash.bashrc ]] && . /etc/bash.bashrc

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

### Bash options

shopt -s autocd

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Enable extended glob.
shopt -s extglob globstar

# Disable HUP on background jobs when exiting shell.
shopt -u huponexit

### History

# 10000 items in ~/.bash_history
export HISTSIZE=10000
# Don't put duplicate lines in the history and ignore same sucessive entries.
export HISTCONTROL=ignoreboth
# Enable history appending instead of overwriting.
shopt -s histappend

### Functions

git_branch () {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}

### Colors

use_color=false

# Change the window title of X terminals.
case ${TERM} in
    xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*|dvtm*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
        use_color=true
        ;;
    screen*)
        PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\033\\"'
        use_color=true
        ;;
esac

# Set colorful PS1 only on colorful terminals.
if ${use_color} ; then
    # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
    if type -P dircolors >/dev/null ; then
        if [[ -f ~/.dir_colors ]] ; then
            eval $(dircolors -b ~/.dir_colors)
        elif [[ -f /etc/DIR_COLORS ]] ; then
            eval $(dircolors -b /etc/DIR_COLORS)
        fi
    fi

    if [[ ${EUID} == 0 ]] ; then
        PS1='\[\033[01;31m\]\h\[\033[01;34m\] \w \[\033[00m\]\$ '
    else
        PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \[\033[01;31m\]$(git_branch)\[\033[00m\]\$ '
    fi

    alias ls='ls --color=auto'
    alias grep='grep --colour=auto'
    alias egrep='egrep --colour=auto'
    alias fgrep='fgrep --colour=auto'
else
    if [[ ${EUID} == 0 ]] ; then
        # show root@ when we don't have colors
        PS1='\u@\h \w \$ '
    else
        PS1='\u@\h \w \$ '
    fi
fi

### Aliases
alias ag='ag --smart-case --pager "less -FRSX"'
alias bye='kill -9 $$'
alias dquilt='quilt --quiltrc ~/.quiltrc-dpkg'
alias l='ls -lArt'
alias ll='ls -l'
alias vi=vim
alias view='vim -R'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'                    # 'rm -i' prompts for every file

### Environment
export LESS='-FRSXi'
export LESSCHARSET='UTF-8'
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
#export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

export PAGER=less

export EDITOR=vim
export VISUAL=vim
export MAIL=~/Maildir
export PYTHONSTARTUP=~/.pythonrc
export MANPATH=~/.local/share/man:$MANPATH
export RIPGREP_CONFIG_PATH=~/.config/ripgrep/ripgreprc
[ -n "$GNOME_KEYRING_CONTROL" -a -z "$GPG_AGENT_INFO" ] && \
    export GPG_AGENT_INFO="$GNOME_KEYRING_CONTROL/gpg:0:1"

[[ -d ~/local/bin ]] && PATH=~/local/bin:$PATH
[[ -d ~/.local/bin ]] && PATH=~/.local/bin:$PATH
export PATH=~/go/bin:~/.cargo/bin:$PATH

# Try to keep environment pollution down, EPA loves us.
unset use_color

# Load local config
[[ -f ~/.local.bashrc ]] && . ~/.local.bashrc

# vim: set et sw=4 ts=4 sts=4:
