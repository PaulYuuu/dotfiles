if (( $+commands[eza] )); then
  alias ls="eza"
  alias ll="ls -lh --time-style=long-iso"
  alias lsa="ls -A"
  alias lla="ls -Alh"
  alias tree="ls --tree"
fi

alias mv="mv -i"
alias cp="cp -i"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

(( $+commands[nvim] )) && alias vim="nvim"
