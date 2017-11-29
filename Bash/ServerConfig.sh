#!/bin/bash

cd

if grep -iq centos /etc/*-release; then
    sudo yum install -y git
else
    sudo apt-get install -y git
fi

git clone https://github.com/AlejandroSalgadoG/Vim.git
git clone https://github.com/AlejandroSalgadoG/Bash.git

echo "source ~/Bash/bashrc" > .bashrc
echo "source ~/Bash/bash_aliases" > .bash_aliases

sed -i "16d" Bash/bashrc
sed -i '16iPS1="${HC}${WHI}\\T ${RED} you are in ${WHI}\\h ${RED}\\w $YEL-> $RS"' Bash/bashrc
sed -i "24d" Bash/bashrc

sed -i "s/Github\///g" Bash/bash_aliases

cp Vim/vimrc .vimrc

sed -i "s/Github\///g" .vimrc
