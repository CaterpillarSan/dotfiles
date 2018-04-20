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
# cloudsim
alias javacsim=' javac -classpath .:~/Desktop/Simulation/cloudsim_jar/cloudsim.jar'
alias javasim=' java -classpath .:~/Desktop/Simulation/cloudsim_jar/cloudsim.jar'


# cd
alias cds='cd /Users/caterpillar/Desktop/Simulation'
alias cdr='cd /Users/caterpillar/Desktop/MyCodes/ronbun'
alias cdd='cd ~/Desktop/DCatch'
alias cdh='cd ~/Desktop/HBase'
# プロンプトの設定
export PS1='\e[32m\][\w]  \e[36m\]\n( ＾∀＾) \[\e[0m\] \$ '
export PATH=/Library/Frameworks/Python.framework/Versions/2.7.14_2/bin:$PATH:/Users/caterpillar/scala/scala-2.12.5/bin
