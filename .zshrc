# source /Users/andre.justo/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# History settings
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
setopt append_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_expire_dups_first

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit

# Set a blazingly fast keyboard repeat rate - requires OS session restart
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

export PATH="$HOME/Applications/nvim/bin:$PATH"
export PATH="$HOME/homebrew/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export HOMEBREW_PREFIX="$HOME/homebrew"
export HOMEBREW_REPOSITORY="$HOME/homebrew"
export HOMEBREW_CELLAR="$HOME/homebrew/Cellar"
export HOMEBREW_CASK_OPTS="--appdir=$HOME/Applications"

alias vim="nvim"
alias v="nvim"
alias ls="eza --icons=always"

# zoxide
eval "$(zoxide init zsh)"
alias cd="z"

# starship
eval "$(starship init zsh)"

# mise
eval "$(/opt/homebrew/bin/mise activate zsh)"
export NODE_OPTIONS="--max-old-space-size=8192"
export HOME=$HOME
