# Set terminal to vim like mode
export EDITOR="/usr/local/bin/vim"
set -o vi

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
if [ "$HOME" == "/Users/austinraney" ];then
	NETCDF=/usr/local/include
	DYLD_FALLBACK_LIBRARY_PATH=/usr/local/gfortran/lib/
	NCARG_ROOT=/usr/local/ncl-6.5.0
	AWSCLI=$HOME/Library/Python/3.6/bin/
	CONDA=$HOME/miniconda3/bin

	PATH=$PATH:$AWSCLI:$NCARG_ROOT/bin:$CONDA
	export PATH
	export NETCDF
	export NCARG_ROOT
	export DYLD_FALLBACK_LIBRARY_PATH

	# nnn file browser shortcuts
	export NNN_BMS='s:~/box/school/fall19;h:~/github;b:~/box;d:~/Dropbox'
	export NNN_CONTEXT_COLORS='2222'
	export NNN_TMPFILE="$HOME/.config/nnn/.lastd"

fi

if [ "$HOME" == "/Users/SDML" ];then
	NETCDF=/usr/local/include;
	DYLD_LIBRARY_PATH=/Users/SDML/GCC-7.3.0/lib/
	NCARG_ROOT=/usr/local/ncl-6.5.0

	PATH=$HOME/.scripts:$HOME/GCC-7.3.0/bin/:$NCARG_ROOT/bin:$PATH
	export NETCDF
	export DYLD_LIBRARY_PATH
	export NCARG_ROOT
fi

# pandoc bash completion
eval "$(pandoc --bash-completion)"

# Bash completions
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
    # if not found in /usr/local/etc, try the brew --prefix location
    [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
	. $(brew --prefix)/etc/bash_completion.d/git-completion.bash
}

# Fuzzy finder history with fzf
[ -f /usr/local/Cellar/fzf/0.18.0/shell/key-bindings.bash ] && \
	source /usr/local/Cellar/fzf/0.18.0/shell/key-bindings.bash 

PATH=$PATH:/Library/Frameworks/GDAL.framework/Programs/:/Library/Frameworks/GDAL.framework/Versions/2.2/Programs/:$HOME/.tools/:/Library/Frameworks/Python.framework/Versions/3.6/bin:/Library/Frameworks/Python.framework/Versions/3.7/bin
export PATH

# set grep to never show directories in search
GREP_OPTIONS="--directories=skip"


# Set terminal look
# export CLICOLOR=1
export LSCOLORS=cxgxhdexbxegedabagacad
export tfmt="%Y-%m-%d %H:%M"

# make terminal look pretty
export CLICOLOR=1
export TERM=xterm-256color
export PS1="\[\033[38;5;9m\][\[$(tput sgr0)\]\[\033[38;5;10m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;7m\]\W\[$(tput sgr0)\]\[\033[38;5;9m\]]\[$(tput sgr0)\]\[\033[38;5;2m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

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

# Conda bash autocomplete

export PATH="$HOME/.poetry/bin:$PATH"
