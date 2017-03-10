export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Use bash-completion, if available
if [ -f /sw/etc/bash_completion ]; then
   . /sw/etc/bash_completion
fi

export NVM_DIR="$HOME/.nvm"
. "$(brew --prefix nvm)/nvm.sh"


NVM_SYMLINK_CURRENT=true


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
