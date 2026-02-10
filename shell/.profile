# Set terminal to vim like mode
export EDITOR="nvim"
set -o vi

# For running docker container gui's
export IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')

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
. "$HOME/.cargo/env"

export SSH_SK_PROVIDER="${HOME}/.local/lib/sk-libfido2.dylib"
