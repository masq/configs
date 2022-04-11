#!/usr/bin/env zsh
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export FPATH="${ZSH}/custom/functions:${FPATH}"
export DEFAULT_USER="$USER"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"
#ZSH_THEME="agnoster"

# POWERLEVEL9K_MODE="awesome-patched"

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=5
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

POWERLEVEL9K_DIR_NOT_WRITABLE_BACKGROUND='001'
POWERLEVEL9K_DIR_NOT_WRITABLE_FOREGROUND='255'
POWERLEVEL9K_DIR_ETC_BACKGROUND='003'
POWERLEVEL9K_DIR_ETC_FOREGROUND='000'
POWERLEVEL9K_DIR_HOME_BACKGROUND='002'
POWERLEVEL9K_DIR_HOME_FOREGROUND='255'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='057'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='255'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='004'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='255'

POWERLEVEL9K_VIRTUALENV_BACKGROUND='012'
POWERLEVEL9K_VIRTUALENV_FOREGROUND='255'
POWERLEVEL9K_PYENV_BACKGROUND='011'
POWERLEVEL9K_PYENV_FOREGROUND='000'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
	#root_indicator
	os_icon
	#context
	virtualenv
	pyenv
	dir
	vcs
)

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
	status
	#ssh
	time
)

POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S %y-%m-%d}"

# Add a space in the first prompt
#POWERLEVEL9K_PROMPT_PREFIX="%f"

# Visual customisation of the second prompt line
local user_symbol="$"
local user_color="black"
if [[ $(print -P "%#") =~ "#" ]]; then
    user_symbol = "#"
	user_color = "red"
fi

#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{yellow}%} $user_symbol%{%b%f%k%F{yellow}%} %{%f%}"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="\u2570%K{${usercolor}}${user_symbol} %f"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
#	git
#	python
#	virtualenv
#	virtualenvwrapper
)

export VIRTUAL_ENV_DISABLE_PROMPT=0

source "$ZSH/oh-my-zsh.sh"

#############################################################################
#
# User configuration
#
#############################################################################
uname | read OS
export PATH="$HOME/bin/:$HOME/.pyenv/plugins/pyenv-virtualenv/shims:$HOME/.pyenv/bin:/usr/local/sbin:$PATH"
export EDITOR=vim
if [ "$OS" = "Darwin" ]; then
	export JAVA_HOME='/usr/libexec/java_home' # For MacOS
fi
export GO111MODULE=on

# Pyenv caching
pyenv() {
  eval "$(command pyenv init --no-rehash - zsh)"
  pyenv "$@"
}
# call pyenv so it's ready to go in a lightweight way. Kinda a hack... bleh
# Interestingly, this gets rid of the caching...?
pyenv --version > /dev/null

# export PYENV_DEBUG=1

#eval "$(pyenv virtualenv-init -)"

# Load our custom functions
autoload print_status
autoload print_info print_success print_error print_warn

autoload start_ssh_agent

source "$HOME/.zsh_aliases"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
