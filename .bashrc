#bashrc

# エイリアスの設定
# ls（カラー表示）
alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -laG'

# javassist関連
alias javaccp='javac -classpath ":/Users/caterpillar/Desktop/Labo/javassist/javassist.jar"'

alias javacp='java -classpath ":/Users/caterpillar/Desktop/Labo/javassist/javassist.jar"'

# cd
alias cdc='cd /Users/caterpillar/Desktop/MyCodes'
alias cdjava='cd /Users/caterpillar/Desktop/Labo/javassist'
# プロンプトの設定
#PS1='\[\e[34m\]\w \[\e[37m\]\$\[\e[0m\] '
PS1='\e[36mヽ|´ ｀*ξ|ﾉ \e[34m\w \e[37m\$ \e[0m'
