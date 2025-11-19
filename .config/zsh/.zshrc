function is_dirty() {
  test -n "$(yadm status --porcelain)" ||
    ! yadm diff --exit-code --stat --cached origin/main >/dev/null
}

function warn_dirty() {
  if is_dirty $?; then
    echo -e "\e[1;36m[[dotfiles]]\e[m"
    echo -e "\e[1;33m[warn] DIRTY DOTFILES\e[m"
    echo -e "\e[1;33m    -> Push your local changes in dotfiles\e[m"
  fi
}

[[ -o login ]] || warn_dirty

eval "$(sheldon source)"

ssh-add -l 2>/dev/null | grep -q 'SHA256' || eval $(keychain --eval --nogui --quiet --agents ssh ~/.ssh/id_ed25519 ~/.ssh/signing-key)

source "$XDG_CONFIG_HOME/zsh/.aliases"

setopt auto_cd
setopt hist_ignore_all_dups
setopt nonomatch

bindkey '^ ' autosuggest-accept

bindkey ' ' zeno-auto-snippet
bindkey '^]' zeno-ghq-cd
bindkey '^r' zeno-history-selection
bindkey '^x' zeno-insert-snippet
