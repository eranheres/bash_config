#export OPENAI_API_KEY_NVIM=$(grep OPENAI_API_KEY_NVIM $(dirname "$0")/config.yml | cut -d' ' -f2)
export OPENAI_API_KEY=$(grep OPENAI_API_KEY $(dirname "$0")/config.yml | cut -d' ' -f2)
[ -f ~/.lazyshell.zsh ] && source ~/.lazyshell.zsh
alias nvenv='python3 -m venv .venv && source .venv/bin/activate && pip install --upgrade pip'
alias avenv='source .venv/bin/activate'

alias nvim-a='NVIM_APPNAME=nvim-a nvim'
alias nvim-c='NVIM_APPNAME=nvim-c nvim'
alias nvim-ios='NVIM_APPNAME=nvim-ios \nvim'
alias nvim-py='NVIM_APPNAME=nvim-python \nvim'
alias nvim-common='NVIM_APPNAME=nvim-common \nvim'
alias nvim-ios-starter='NVIM_APPNAME=nvim-ios-starter \nvim'

source /Users/eranheres/.config/nvims/nvim_appnames

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

