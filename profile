# Terminal colors
export PS1="\[\033[36m\]\u\[\033[m\]:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# common alias
alias ls='ls -GFh'
alias grep='grep --color=always'
alias zgrep='zgrep --color=always'


# git autocompletion and others
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
alias git='LANG=en_GB git'

# bash as vim
set editing-mode vi
set show-mode-in-prompt on
set vi-ins-mode-string \1\e[6 q\2
set vi-cmd-mode-string \1\e[2 q\2

# optionally:
# switch to block cursor before executing a command
set keymap vi-insert
# RETURN: "\e\n"


