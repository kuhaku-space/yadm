function is_dirty() {
  test -n "$(yadm status --porcelain)" ||
    ! yadm diff --exit-code --stat --cached origin/main >/dev/null
}

function warn_dirty() {
  local dotfiles_dir=~/.local/share/yadm/repo.git
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

autoload -Uz compinit && compinit -d "$XDG_STATE_HOME/zsh/zcompdump-$ZSH_VERSION"

# See: https://qiita.com/nacika_ins/items/465e89a7b3fbeb373605
eval "$(sheldon source)"
eval "$(zoxide init zsh)"

if [[ -n $ZENO_LOADED ]]; then
  bindkey ' ' zeno-auto-snippet

  # fallback if snippet not matched (default: self-insert)
  # export ZENO_AUTO_SNIPPET_FALLBACK=self-insert

  # if you use zsh's incremental search
  # bindkey -M isearch ' ' self-insert

  bindkey '^m' zeno-auto-snippet-and-accept-line

  # bindkey '^i' zeno-completion

  bindkey '^x ' zeno-insert-space
  bindkey '^x^m' accept-line
  bindkey '^x^z' zeno-toggle-auto-snippet

  # fallback if completion not matched
  # (default: fzf-completion if exists; otherwise expand-or-complete)
  # export ZENO_COMPLETION_FALLBACK=expand-or-complete
fi

eval $(keychain --eval --nogui --quiet --agents ssh ~/.ssh/id_ed25519)
eval $(keychain --eval --nogui --quiet --agents ssh ~/.ssh/signing-key)

source "$XDG_CONFIG_HOME/zsh/.aliases"
source "$XDG_CONFIG_HOME/fzf/fzf.zsh"

setopt auto_cd
setopt hist_ignore_all_dups
setopt nonomatch

function fzf-ghq() {
  local src=$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*" --reverse)
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}

function fzf-select-history() {
  BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER" --reverse)
  CURSOR=$#BUFFER
  zle reset-prompt
}

zle -N fzf-ghq
zle -N fzf-select-history
bindkey '^]' fzf-ghq
bindkey '^r' fzf-select-history
bindkey '^ ' autosuggest-accept
