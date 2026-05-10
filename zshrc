# zshrc

# エイリアスの設定
alias ls='ls -GF'
alias ll='ls -lGF'
alias la='ls -laGF'
alias sed='gsed'
alias which='whence -a'
alias vim='nvim'
alias kube='kubectl'
alias lg='lazygit'
alias bx='bundle exec'
alias ocaml="rlwrap ocaml"

# cd したら ls する
cd() {
    builtin cd "$@" && ls
}

# vi モード
bindkey -v

# エディタ
export EDITOR='nvim'

# プロンプト (git ブランチ + dirty state 表示)
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' formats '[%b%u%c]'
setopt PROMPT_SUBST
PROMPT='%F{green}[%~]%f %F{red}${vcs_info_msg_0_}%f
%F{cyan}( ＾∀＾)%f $ '

# LSCOLORS
export LSCOLORS=gxfxcxdxbxegedabagacad

# PATH
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# ヒストリ
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE SHARE_HISTORY

# zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Tab: 候補があれば accept、なければ通常補完
_autosuggest_or_complete() {
  if [[ -n $POSTDISPLAY ]]; then
    zle autosuggest-accept
  else
    zle expand-or-complete
  fi
}
zle -N _autosuggest_or_complete
bindkey '\t' _autosuggest_or_complete

# zsh-syntax-highlighting (must be last)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zoxide (z コマンド)
eval "$(zoxide init zsh)"
