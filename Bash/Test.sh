#!/bin/bash

groupName=aljoh
project=/home/alejandro/Dropbox/Universidad/Compiladores/lexer_st0270
jproject=/home/alejandro/Dropbox/Universidad/Compiladores/exprcomp

path=src/'test'/java/co/edu/eafit/dis/st0270/p20151/$groupName/pl0

alias pom="cd $project"
alias jfile="cd $project/src/main/jflex"
alias afile="cd $project/src/main/antlr4"
alias main="cd $project/src/main/java/co"
alias token="cd $project/src/main/java/co/edu/eafit/dis/st0270/p20151/$groupName/pl0/tokens"
alias proo="cd $project/src/test/java/co/edu/eafit/dis/st0270/p20151/$groupName/pl0"
alias var="cd $project/src/main/java/co/edu/eafit/dis/st0270/p20151/$groupName/pl0/parser"
alias grun="java org.antlr.v4.runtime.misc.TestRig"

alias jpom="cd $jproject"
alias jant="cd $jproject/src/main/antlr4"
alias jvar="cd $jproject/src/main/java/co/edu/eafit/dis/st0270/expr/parser"

maven(){
    dir=`pwd`
    if [ -z $1 ]; then
        cd $project
        mvn compile
        if [ $? -eq 0 ]; then
            for i in $(ls $path); do
                echo && cat $path/$i && echo
                java -cp $CLASSPATH:./target/classes/ co.Main$groupName'AntlrParser' $path/$i
                echo
            done
        fi
    else
        cd $project
        if [ "$1" == "c" ];then
            mvn clean
        elif [ "$1" == "co" ]; then
            mvn compile
        else
            if [ "$1" == "a" ]; then
                program=AntlrLexer
            elif [ "$1" == "j" ]; then
                program=JFlexLexer
            else
                cd $dir
                echo AYUDA:
                echo "1) \"maven\" ejecuta el parser"
                echo "2) \"maven a\" ejecuta el lexer de antlr"
                echo "3) \"maven j\" ejecuta el lexer de jflex"
                echo "4) \"maven c\" ejecuta mvn clean"
                echo "5) \"maven co\" ejecuta mvn compile"
                return 1
            fi
            mvn compile
            if [ $? -eq 0 ]; then
                for i in $(ls $path); do
                    echo
                    cat $path/$i
                    echo
                    echo "################ Ejecucion: $program ################"
                    echo
                    java -cp $CLASSPATH:./target/classes/ co.Main$groupName$program $path/$i
                    echo
                done
            fi
        fi
    fi
    cd $dir
}
