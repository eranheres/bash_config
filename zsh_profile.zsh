#export OPENAI_API_KEY_NVIM=$(grep OPENAI_API_KEY_NVIM $(dirname "$0")/config.yml | cut -d' ' -f2)
ZSH_THEME="powerlevel10k/powerlevel10k"


eval "$(/opt/homebrew/bin/brew shellenv)"
source $HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme


export OPENAI_API_KEY=$(grep OPENAI_API_KEY $(dirname "$0")/config.yml | cut -d' ' -f2)
export SERPER_API_KEY=$(grep SERPER_API_KEY $(dirname "$0")/config.yml | cut -d' ' -f2)
export ANTHROPIC_API_KEY=$(grep ANTHROPIC_API_KEY $(dirname "$0")/config.yml | cut -d' ' -f2)

[ -f ~/.lazyshell.zsh ] && source ~/.lazyshell.zsh
alias nvenv='python3 -m venv .venv && source .venv/bin/activate && pip install --upgrade pip'
alias avenv='source .venv/bin/activate'

alias n='NVIM_APPNAME=nvim-python \nvim'
alias obs='cd /Users/eranheres/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/second-brain; NVIM_APPNAME=nvim-obsidian nvim .'
alias nvim-a='NVIM_APPNAME=nvim-a nvim'
alias nvim-b='NVIM_APPNAME=nvim-b \nvim'
alias nvim-obs='NVIM_APPNAME=nvim-obsidian nvim'
alias nvim-test='NVIM_APPNAME=nvim-test nvim'
alias nvim-lua='NVIM_APPNAME=nvim-lua nvim'
alias nvim-ios='NVIM_APPNAME=nvim-ios \nvim'
alias nvim-py='NVIM_APPNAME=nvim-python \nvim'
alias nvim-common='NVIM_APPNAME=nvim-common \nvim'
alias nvim-ios-starter='NVIM_APPNAME=nvim-ios-starter \nvim'

# source /Users/eranheres/.config/nvims/nvim_appnames

export PATH="$HOMEBREW_PREFIX/opt/ruby/bin:$PATH"
#
# Used for xcodeproj on nvim
export PATH="/Users/eranheres/projects/codelldb-aarch64-darwin:$PATH"
export PATH="/Library/TeX/texbin:$PATH"
export SECOND_BRAIN_DIR="/Users/eranheres/Library/Mobile Documents/iCloud~md~obsidian/Documents/second-brain"
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
bindkey -v
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

# fzf for history search using CTRL-R
eval "$(fzf --zsh)"


# Bind CTRL-J to fzf's history search
bindkey -r '^R'
bindkey '^K' fzf-history-widget


# Customize prompt
[[ ! -f ./keys.sh ]] || source ./keys.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
