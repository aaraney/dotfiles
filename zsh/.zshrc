# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
git
poetry
)

source $ZSH/oh-my-zsh.sh

# User configuration

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set vi mode
bindkey -v
bindkey '^?' backward-delete-char
bindkey -a u undo
bindkey -a '^R' redo

##################################
#      .bash_profile imports     #
##################################

# Set terminal to vim like mode
export EDITOR="/usr/local/bin/vim"
# set -o vi

# For running docker container gui's
export IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')

# Change default history size
export HISTFILESIZE=100000
export HISTSIZE=100000


#########################################################
#							#
#		ENVIRONMENT VARIABLES			#
#							#
#########################################################
if [[ "$HOME" == "/Users/austinraney" ]];then
	NETCDF=/usr/local/include
	DYLD_FALLBACK_LIBRARY_PATH=/usr/local/gfortran/lib/
	NCARG_ROOT=/usr/local/ncl-6.5.0
	# AWSCLI=$HOME/Library/Python/3.6/bin/
	CONDA=$HOME/miniconda3/bin
	POETRY=$HOME/.poetry/bin

	PATH=$PATH:$NCARG_ROOT/bin:$CONDA:$POETRY
	# PATH=$PATH:$AWSCLI:$NCARG_ROOT/bin:$CONDA:$POETRY
	export PATH
	export NETCDF
	export NCARG_ROOT
	export DYLD_FALLBACK_LIBRARY_PATH

	# nnn file browser shortcuts
	export NNN_BMS='s:~/box/school/fall19;h:~/github;b:~/box;d:~/Dropbox'
	export NNN_CONTEXT_COLORS='2222'
	export NNN_TMPFILE="$HOME/.config/nnn/.lastd"

fi

if [[ "$HOME" == "/Users/SDML" ]];then
	NETCDF=/usr/local/include;
	DYLD_LIBRARY_PATH=/Users/SDML/GCC-7.3.0/lib/
	NCARG_ROOT=/usr/local/ncl-6.5.0

	PATH=$HOME/.scripts:$HOME/GCC-7.3.0/bin/:$NCARG_ROOT/bin:$PATH
	export NETCDF
	export DYLD_LIBRARY_PATH
	export NCARG_ROOT
fi

# Fuzzy finder history with fzf
[ -f /usr/local/Cellar/fzf/0.18.0/shell/key-bindings.zsh ] && \
	source /usr/local/Cellar/fzf/0.18.0/shell/key-bindings.zsh

PATH=$PATH:/Library/Frameworks/GDAL.framework/Programs/:/Library/Frameworks/GDAL.framework/Versions/2.2/Programs/:$HOME/.tools/:/Library/Frameworks/Python.framework/Versions/3.6/bin:/Library/Frameworks/Python.framework/Versions/3.7/bin
export PATH

# set grep to never show directories in search
GREP_OPTIONS="--directories=skip"


# Set terminal look
# export CLICOLOR=1
# export LSCOLORS=cxgxhdexbxegedabagacad
export tfmt="%Y-%m-%d %H:%M"

# make terminal look pretty
export CLICOLOR=1
export TERM=xterm-256color

# Alias and Function rc files to shorten bash_profile
[ -f $HOME/.config/shell/aliasrc ] && source $HOME/.config/shell/aliasrc
[ -f $HOME/.config/shell/funcrc ] && source $HOME/.config/shell/funcrc


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

export PATH="/usr/local/opt/qt/bin:$PATH"
