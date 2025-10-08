# Plugin manager (sheldon)
eval "$(sheldon source)"

# Initialize completion system
autoload -Uz compinit
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}/zsh/zcompcache"
compinit -Cd "${XDG_CACHE_HOME}/zsh/zcompdump"

# Set up fzf key bindings and fuzzy completion
(( $+commands[fzf] )) && source <(fzf --zsh)

# Bind atuin with ctrl-r but not up arrow
(( $+commands[atuin] )) && eval "$(atuin init zsh --disable-up-arrow)"

# Hook direnv
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"

# Bind zoxide with j
(( $+commands[zoxide] )) && eval "$(zoxide init zsh --cmd j)"
