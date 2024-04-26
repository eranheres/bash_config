brew install zsh

# check if OPENAI_API_KEY is set and if not exit
if [ -z "$OPENAI_API_KEY" ]; then
	echo "OPENAI_API_KEY is not set"
	exit 1
fi
# check if OPENAI_API_KEY is set defined in config file config.yaml and if not exit
if [ -z "$(grep OPENAI_API_KEY config.yaml)" ]; then
	echo "OPENAI_API_KEY is not set in config.yaml"
	exit 1
fi

# set the OPENAI_API_KEY from config.yaml into the environment variable
OPENAI_API_KEY=$(grep OPENAI_API_KEY config.yaml | cut -d' ' -f2)

curl -o ~/.lazyshell.zsh https://raw.githubusercontent.com/not-poma/lazyshell/master/lazyshell.zsh

# source zsh_profile.zsh in PWD dir to zshrc if not sourced already
if [ -z "$(grep zsh_profile.zsh ~/.zshrc)" ]; then
	echo "[ -f $PWD/zsh_profile.zsh ] && source $PWD/zsh_profile.zsh" >>~/.zshrc
fi

pip install shell-gpt

# aliases
alias hg="history | grep"

brew install fd
