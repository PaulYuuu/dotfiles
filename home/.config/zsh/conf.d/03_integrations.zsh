# Plugin manager (sheldon)
eval "$(sheldon source)"

# Initialize completion system
autoload -Uz compinit
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}/zsh/zcompcache"
compinit -Cd "${XDG_CACHE_HOME}/zsh/zcompdump"

(( $+commands[atuin] )) && eval "$(atuin init zsh --disable-up-arrow)"
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
(( $+commands[fzf] )) && source <(fzf --zsh)
(( $+commands[mise] )) && eval "$(mise activate zsh)"
(( $+commands[zoxide] )) && eval "$(zoxide init zsh --cmd j)"
