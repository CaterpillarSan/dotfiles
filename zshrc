# zshrc

# エイリアスの設定
alias ls='ls -GF'
alias ll='ls -lGF'
alias la='ls -laGF'
alias sed='gsed'
alias which='whence -a'
alias kube='kubectl'
alias bx='bundle exec'
alias ocaml="rlwrap ocaml"

# cd したら ls する
cd() {
    builtin cd "$@" && ls
}

# vi モード
bindkey -v

# エディタ
export EDITOR='vim'

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
