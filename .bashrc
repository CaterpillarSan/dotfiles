#bashrc

# エイリアスの設定
# ls（カラー表示）
alias ls='ls -GF'
alias ll='ls -lGF'
alias la='ls -laGF'

cd () {
	builtin cd "$@" && ls
}

alias classname='command ls Jikken | grep -o .*\.class | sed -e s/.class//g | tr '\n'' 

# java
alias javassistc='javac -classpath ".:./javassist.jar"'
alias javacbot='javac -cp ".:~/java-library/jbotsim.jar"'
alias javabot='java -cp ".:~/java-library/jbotsim.jar"'

alias javassist='java -classpath ".:./javassist.jar"'
# cloudsim
alias javacsim=' javac -classpath ".:cloudsim_jar/cloudsim.jar"'
alias javasim=' java -classpath ".:cloudsim_jar/cloudsim.jar"'

# git
alias git-dbranch='git branch --merged | grep -v '*' | xargs -I % git branch -d %'

# cd
alias cds='cd ~/scala/simulator'
alias cdr='cd ~/Desktop/MyCodes/ronbun'
alias cdgo='cd ~/go/src/github.com/CaterpillarSan'
alias cdp='/Users/caterpillar/Desktop/Labo/Papers'

alias kube='kubectl'

# bashの表示のやつ
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\e[32m\][\w] \e[31m\]$(__git_ps1 [%s]) \e[36m\]\n( ＾∀＾) \[\e[0m\] \$ '
export LSCOLORS=gxfxcxdxbxegedabagacad

# PATHまわり
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
export NODEBREW_ROOT=/usr/local/var/nodebrew
export PATH=$PATH:$GOPATH/bin
export PATH=/usr/local/opt/openssl/bin:$PATH
export PATH=/usr/local/var/nodebrew/current/bin:$PATH
export PATH=/Library/Frameworks/Python.framework/Versions/2.7.14_2/bin:$PATH
export PATH=/Users/caterpillar/scala/scala-2.12.5/bin:$PATH
export PATH=/usr/local/Cellar/git/2.19.0_2/bin:$PATH
