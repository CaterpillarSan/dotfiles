# bash_alias

# エイリアスの設定
# ls（カラー表示）
alias ls='ls -GF'
alias ll='ls -lGF'
alias la='ls -laGF'
alias sed='gsed'
alias which='type -a'


cd () {
	builtin cd "$@" && ls
}

# git
alias git-dbranch='git branch --merged | grep -v '*' | xargs -I % git branch -d %'


alias kube='kubectl'
alias bx='bundle exec'
alias ocaml="rlwrap ocaml"


