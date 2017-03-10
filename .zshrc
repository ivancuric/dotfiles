source ~/.zplug/init.zsh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# auto change directory
setopt AUTO_CD

# use brace
setopt BRACE_CCL

# auto directory pushd that you can get dirs list by cd -[tab]
setopt AUTO_PUSHD

# compacked complete list display
setopt LIST_PACKED

# no beep sound when complete list displayed
setopt NOLISTBEEP

# multi redirect (e.x. echo "hello" > hoge1.txt > hoge2.txt)
setopt MULTIOS

## Command history configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt HIST_IGNORE_DUPS  # ignore duplication command history list
setopt HIST_IGNORE_SPACE # ignore when commands starts with space
setopt SHARE_HISTORY     # share command history data
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_LEX_WORDS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt MENU_COMPLETE
setopt EXTENDED_GLOB
setopt NO_NOMATCH
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
setopt PATH_DIRS           # Perform path search even on command names with slashes.
setopt AUTO_MENU           # Show completion menu on a successive tab press.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
unsetopt FLOW_CONTROL      # Disable start/stop characters in shell editor.


export CLICOLOR=1
export TERM=xterm-256color
export BLOCK_SIZE=human-readable
export PATH=/usr/local/bin:$PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/usr/local/sbin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"

# Virtualenv
export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

precmd() {
if [[ -n $PYENV_SHELL ]]; then
  local version
  version=${(@)$(pyenv version)[1]}
  if [[ $version = system ]]; then
    PROMPT="%(?.%F{magenta}.%F{red})❯%f "
  else
    PROMPT="(pyenv $version) %(?.%F{magenta}.%F{red})❯%f "
  fi
fi
}



# Nvm
export NVM_DIR="$HOME/.nvm"
. "$(brew --prefix nvm)/nvm.sh"

export NODEDIR=$(which node)

zplug "plugins/git", from:oh-my-zsh
zplug "rupa/z", use:z.sh
zplug "andrewferrier/fzf-z"
# zplug "b4b4r07/enhancd", use:init.sh
# zplug "chrissicool/zsh-256color"
zplug "sindresorhus/pure"
# zplug "zsh-users/zsh-history-substring-search", nice:19
zplug "zsh-users/zsh-syntax-highlighting", nice:18
zplug "zsh-users/zsh-completions"


zstyle ':filter-select' max-lines 10
zstyle ':filter-select' extended-search yes
zstyle ':filter-select' case-insensitive yes
zstyle ':filter-select' rotate-list yes
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' menu select
zstyle ':completion:*' menu select=20
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${ZDOTDIR:-$HOME}/.zcompcache"
zstyle ':prezto:module:syntax-highlighting' highlighters \
'main' \
'brackets' \
'pattern' \
'line' \
'cursor' \
'root'

###-begin-npm-completion-###
if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###


#
# Editors
#

export EDITOR='micro'
export PAGER='less'
# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-g -i -M -R -S -w -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi


# My stuff
source ~/.aliases
source ~/.functions

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

# if zplug check zsh-users/zsh-history-substring-search; then
#   bindkey '^[[A' history-substring-search-up
#   bindkey '^[[B' history-substring-search-down
# fi

# emacs like keybind (e.x. Ctrl-a, Ctrl-e)
bindkey -e
KEYTIMEOUT=1
