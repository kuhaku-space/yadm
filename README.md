# dotfiles

[yadm](https://yadm.io/) で管理している dotfiles。WSL2 (Ubuntu) 上の zsh 環境を想定。

## セットアップ

```sh
# yadm を入れる（未インストールの場合）
sudo apt install yadm  # もしくは mise u -g yadm

# クローンして bootstrap を実行
yadm clone ssh://git@github.com/kuhaku-space/yadm.git
yadm bootstrap
```

`yadm bootstrap`（[.config/yadm/bootstrap](.config/yadm/bootstrap)）が以下を行う:

- この README など `$HOME` に展開したくないファイルを sparse-checkout で除外
- `apt` パッケージ（build-essential, libssl-dev, keychain, zsh など）のインストール
- デフォルトシェルを zsh に変更
- SSH 鍵（`id_ed25519` / `signing-key`）の生成
- `/etc/zsh/zshenv` への `ZDOTDIR` 追記
- [mise](https://mise.jdx.dev/) のインストールと、`mise install` による開発ツール一式の導入
- 必要なディレクトリの作成

## 構成

| パス | 内容 |
| --- | --- |
| [.config/zsh/](.config/zsh/) | zsh 設定（`.zshenv` / `.zshrc` / `.aliases`） |
| [.config/mise/config.toml](.config/mise/config.toml) | mise が管理する開発ツール一覧 |
| [.config/sheldon/plugins.toml](.config/sheldon/plugins.toml) | zsh プラグイン（[sheldon](https://sheldon.cli.rs/)） |
| [.config/zeno/config.yml](.config/zeno/config.yml) | [zeno.zsh](https://github.com/yuki-yano/zeno.zsh) のスニペット |
| [.config/git/](.config/git/) | git 設定 |
| [.config/npm/](.config/npm/), [.config/pnpm/](.config/pnpm/) | Node パッケージマネージャ設定 |

## ツールの追加・更新

開発ツールは mise で管理している。追加・更新は config を編集して `mise install`:

```sh
mise use -g <tool>   # config.toml に追記してインストール
mise upgrade         # 更新
```
