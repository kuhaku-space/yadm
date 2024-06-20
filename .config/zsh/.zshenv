export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export HISTFILE="$XDG_STATE_HOME/zsh/history"
export HISTSIZE=10000
export SAVEHIST=10000

# Rust
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# Deno
export DENO_INSTALL="$HOME/.deno"

# zeno.zsh
export ZENO_HOME="$XDG_CONFIG_HOME/zeno"

# WakaTime
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"

export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$DENO_INSTALL/bin"

. "/home/kuhaku/.local/share/cargo/env"
