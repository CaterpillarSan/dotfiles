#bashrc

# エイリアスの設定
# ls（カラー表示）
alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -laG'

alias classname='command ls Jikken | grep -o .*\.class | sed -e s/.class//g | tr '\n'' 

# javassist関連
alias javassistc='javac -classpath ".:./javassist.jar"'

alias javassist='java -classpath ".:./javassist.jar"'

alias testjava='java -classpath ".:/Users/caterpillar/Desktop/DCatch/myTrace"'

# cd
alias cdc='cd /Users/caterpillar/Desktop/MyCodes'
alias cdr='cd /Users/caterpillar/Desktop/MyCodes/ronbun'
alias cds='cd /Users/caterpillar/Desktop/Labo/Share'
alias cdjava='cd /Users/caterpillar/Desktop/Labo/javassist'
alias cdd='cd ~/Desktop/DCatch'
alias cdh='cd ~/Desktop/HBase'
# プロンプトの設定
export PS1='\e[32m\][\w]  \e[36m\]\n( ＾∀＾) \[\e[0m\] \$ '
