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

if [[ ! -o login ]]; then
  # Avoid duplicate warning (See .config/zsh/.zprofile)
  warn_dirty
fi

autoload -Uz compinit && compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
if [[ -f $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION ]]; then
    zcompile $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
fi

# See: https://qiita.com/nacika_ins/items/465e89a7b3fbeb373605
eval "$(sheldon source)"
eval "$(zoxide init zsh)"

if [[ -n $ZENO_LOADED ]]; then
  bindkey ' ' zeno-auto-snippet
  bindkey '^]' zeno-ghq-cd
  bindkey '^r' zeno-history-selection
  bindkey '^x' zeno-insert-snippet
fi

# eval $(keychain --eval --nogui --quiet --agents ssh ~/.ssh/id_ed25519)
# eval $(keychain --eval --nogui --quiet --agents ssh ~/.ssh/signing-key)

source "$XDG_CONFIG_HOME/zsh/.aliases"

setopt auto_cd
setopt hist_ignore_all_dups
setopt nonomatch

bindkey '^ ' autosuggest-accept
